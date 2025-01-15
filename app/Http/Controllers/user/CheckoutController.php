<?php

namespace App\Http\Controllers\user;

use App\Http\Controllers\Controller;
use App\Models\admin\Coupon;
use App\Models\admin\ShippingAddress;
use App\Models\SalesOrder;
use App\Models\ShippingAddress as ModelsShippingAddress;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use App\Models\ShoppingCart;
use App\Models\ShoppingCartDetail;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use App\Mail\OrderMail;
use App\Models\admin\Book;
use App\Models\SalesOrderDetail;
use App\Models\admin\SalesOrder as SalesOrderAdmin;

class CheckoutController extends Controller
{
    function checkoutPage(Request $request)
    {
        if (!Auth::check()) {
            return back()->with('error', 'Vui lòng đăng nhập để mua hàng.');
        }

        $couponCode = $request->input('couponCode');
        $coupon = Coupon::where('CouponCode', $couponCode)->first();
        $userId = Session::get('user')->UserID;
        $shippingAddressDefault = ShippingAddress::where('UserID', $userId)->where('IsDefault', 1)->first();
        $shippingAddressList = ShippingAddress::where('UserID', $userId)->get();
        $userID = Auth::id();
        if ($userID) {
            $cart = ShoppingCart::firstOrNew(['UserID' => $userID]);
            if (!$cart->CartID) {
                $cart->save();
            }
            $cartID = $cart->CartID;
            $cartItems = ShoppingCartDetail::with('book')->where('CartID', $cartID)->get();
            $totalPrice = 0;
            foreach ($cartItems as $cartItem) {
                $totalPrice += $cartItem->Quantity * $cartItem->book->CostPrice;
            }
        }
        $bookPrice = $totalPrice;

        if ($shippingAddressDefault) {
            $totalPrice += 10000;
            if ($couponCode) {
                $totalPrice = $totalPrice * (1 - ($coupon->DiscountAmount / 100));
                $totalPrice = number_format($totalPrice, 2, '.', '');
                $discount = ($bookPrice + 10000) - $totalPrice;
                $discount = number_format($discount, 2, '.', '');
                $totalPriceDiscount = $totalPrice;
                return view(
                    "user.checkout-page",
                    compact('shippingAddressDefault', 'totalPriceDiscount', 'bookPrice', 'shippingAddressList', 'discount', 'couponCode')
                );
            }
            $totalPrice = number_format($totalPrice, 2, '.', '');
            return view(
                "user.checkout-page",
                compact('shippingAddressDefault', 'totalPrice', 'bookPrice', 'shippingAddressList', 'couponCode')
            );
        }
        if ($couponCode) {
            $totalPrice = $bookPrice * (1 - ($coupon->DiscountAmount / 100));
            $totalPrice = number_format($totalPrice, 2, '.', '');
            $discount = $bookPrice - $totalPrice;
            $discount = number_format($discount, 2, '.', '');
            return view(
                "user.checkout-page",
                compact('totalPrice', 'bookPrice', 'discount', 'couponCode')
            );
        }
        $totalPrice = number_format($totalPrice, 2, '.', '');
        return view(
            "user.checkout-page",
            compact('totalPrice', 'bookPrice', 'shippingAddressList', 'couponCode')
        );
    }

    function checkoutConfirm(Request $request)
    {
        $paymentType = $request->input('paymentType');

        $couponCode = $request->input('couponCode');
        $coupon = Coupon::where('CouponCode', $couponCode)->first();
        $userID = Auth::id();
        if ($userID) {

            $cart = ShoppingCart::firstOrNew(['UserID' => $userID]);
            if (!$cart->CartID) {
                $cart->save();
            }
            $cartID = $cart->CartID;
            $cartItems = ShoppingCartDetail::with('book')->where('CartID', $cartID)->get();

            // Kiểm tra số lượng trong kho
            foreach ($cartItems as $cartItem) {
                $book = $cartItem->book;
                $stockQuantity = $book->QuantityInStock ?? 0;

                if ($cartItem->Quantity > $stockQuantity) {
                    return redirect()->back()->with('error', 'Bạn đã mua ' . $cartItem->Quantity . ' sách "' . $book->BookTitle . '" nhưng trong kho chỉ còn ' . $stockQuantity . ' cuốn.');
                }
            }

            $totalPrice = 0;
            foreach ($cartItems as $cartItem) {
                $totalPrice += $cartItem->Quantity * $cartItem->book->CostPrice;
            }
        }

        $bookPrice = $totalPrice;
        if ($couponCode && $coupon && !$coupon->IsUsed) {
            $totalPriceOld = $totalPrice + 10000;
            $discountAmount = $coupon->DiscountAmount / 100;
            $discount = $totalPriceOld * $discountAmount;
            $totalPrice = round($totalPriceOld - $discount, 2);

            $coupon->IsUsed = 1;
            $coupon->save();

            $saleOrders['Discount'] = $discountAmount;
        } else {
            $saleOrders['Discount'] = 0;
        }


        if ($totalPrice > 0) {
            // $address = ShippingAddress::where('UserID', $userID)
            //     ->whereRaw('LOWER(Address) = ?', [strtolower($request->query('shippingaddress'))])
            //     ->first();


            $address = ShippingAddress::where('UserID', $userID)
                ->where('IsDefault', 1) // Lấy địa chỉ mặc định
                ->first();

            // Nếu không có địa chỉ mặc định, gán giá trị rỗng hoặc null
            if (!$address) {
                $address = null; // Hoặc ['Address' => ''] nếu muốn để trống
            }


            // dd($address->AddressID);

            $saleOrders['UserID'] = $userID;
            $saleOrders['OrderStatus'] = 'PENDING';
            $saleOrders['ShippingAddressID'] = $address->AddressID;
            $saleOrders['TotalPrice'] = $totalPrice;
            $saleOrders['ShippingFee'] = 10000;
            $saleOrders['OrderDate'] = Carbon::now();

            $Order = SalesOrder::create($saleOrders);

            foreach ($cartItems as $cartItem) {
                $book = $cartItem->book;
                $newStockQuantity = $book->QuantityInStock - $cartItem->Quantity;

                if ($newStockQuantity >= 0) {
                    $book->QuantityInStock = $newStockQuantity;
                    $book->save();
                } else {
                    return redirect()->back()->with('error', 'Số lượng sách "' . $book->BookTitle . '" không đủ trong kho.');
                }

                $saleOrdersDetail['OrderID'] = $Order->OrderID;
                $saleOrdersDetail['BookID'] = $cartItem->book->BookID;
                $saleOrdersDetail['QuantitySold'] = $cartItem->Quantity;
                $saleOrdersDetail['Price'] = $cartItem->book->SellingPrice;
                $saleOrdersDetail['SubTotal'] = $cartItem->book->SellingPrice * $cartItem->Quantity;
                SalesOrderDetail::create($saleOrdersDetail);
            }

            if ($paymentType === 'Cash') {
                // Xử lý thanh toán bằng tiền mặt
                ShoppingCartDetail::where('CartID', $cartID)->delete();

                return view(
                    "user.order-confirm",
                    [
                        'cartItems' => $cartItems,
                        'totalPrice' => $totalPrice,
                        'bookPrice' => $bookPrice,
                        'orderID' => $Order->OrderID
                    ],
                );
            } elseif ($paymentType === 'Online') {
                // Xử lý thanh toán online bằng VNPAY
                $vnpUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
                $vnp_TmnCode = "QV4AJ3NO";
                $vnp_HashSecret = "3CP0V5HCDJ6VFE1YPVYL85YUHK1SGLLP";

                // URL trả về sau khi thanh toán
                $vnp_Returnurl = route('checkout.vnpay_return');

                // Mã tham chiếu đơn hàng
                $vnp_TxnRef = $Order->OrderID;

                // Thông tin đơn hàng
                $vnp_OrderInfo = "Thanh toán đơn hàng " . $Order->OrderID;

                // Loại đơn hàng
                $vnp_OrderType = "billpayment";

                // Đơn vị tiền tệ là VND, nhân với 100 để chuyển đổi từ đồng
                $vnp_Amount = $totalPrice * 100;

                // Ngôn ngữ trả về, 'vn' cho tiếng Việt
                $vnp_Locale = 'vn';

                // Địa chỉ IP khách hàng
                $vnp_IpAddr = $request->ip();

                // Dữ liệu gửi đi VNPAY
                $inputData = array(
                    "vnp_Version" => "2.1.0", // Phiên bản API VNPAY
                    "vnp_TmnCode" => $vnp_TmnCode, // Mã website tại VNPAY
                    "vnp_Amount" => $vnp_Amount, // Số tiền thanh toán (đã nhân với 100)
                    "vnp_Command" => "pay", // Lệnh thanh toán
                    "vnp_CreateDate" => now()->format('YmdHis'), // Thời gian tạo giao dịch
                    "vnp_CurrCode" => "VND", // Đơn vị tiền tệ
                    "vnp_IpAddr" => $vnp_IpAddr, // Địa chỉ IP khách hàng
                    "vnp_Locale" => $vnp_Locale, // Ngôn ngữ giao dịch
                    "vnp_OrderInfo" => $vnp_OrderInfo, // Thông tin đơn hàng
                    "vnp_OrderType" => $vnp_OrderType, // Loại đơn hàng
                    "vnp_ReturnUrl" => $vnp_Returnurl, // URL trả về sau khi thanh toán
                    "vnp_TxnRef" => $vnp_TxnRef, // Mã tham chiếu đơn hàng
                );

                // Sắp xếp mảng dữ liệu theo thứ tự alphabet
                ksort($inputData);

                // Xây dựng chuỗi query từ mảng inputData
                $query = [];
                foreach ($inputData as $key => $value) {
                    $query[] = urlencode($key) . "=" . urlencode($value);
                }
                $queryString = implode('&', $query);

                // Tạo chuỗi hash bảo mật với HMAC-SHA512
                $vnpSecureHash = hash_hmac('sha512', $queryString, $vnp_HashSecret);

                // Thêm mã bảo mật vào URL gửi đến VNPAY
                $vnp_Url = $vnpUrl . "?" . $queryString . "&vnp_SecureHash=" . $vnpSecureHash;

                // Chuyển hướng đến VNPAY để thực hiện thanh toán
                return redirect($vnp_Url);
            }
        }
    }

    function vnpayReturn(Request $request)
    {
        $responseCode = $request->query('vnp_ResponseCode');
        $orderID = $request->query('vnp_TxnRef');
        $order = SalesOrder::find($orderID);

        if (!$order) {
            return redirect()->route('user.checkout-page')->with('error', 'Đơn hàng không tồn tại.');
        }

        if ($responseCode == '00') {
            // Cập nhật trạng thái đơn hàng
            $order->update(['OrderStatus' => 'COMPLETED']);

            // Lấy CartID từ ShoppingCart
            $cart = ShoppingCart::where('UserID', $order->UserID)->first();

            $cartItems = ShoppingCartDetail::with('book')->where('CartID', $cart->CartID)->get();

            if ($cart) {
                // Xóa chi tiết giỏ hàng
                ShoppingCartDetail::where('CartID', $cart->CartID)->delete();
            }

            return view("user.order-confirm", [
                'cartItems' => $cartItems,
                'totalPrice' => $order->TotalPrice,
                'bookPrice' => $order->TotalPrice - $order->ShippingFee,
                'orderID' => $order->OrderID,
            ]);
        }

        return redirect()->route('user.checkout-page')->with('error', 'Thanh toán thất bại.');
    }



    public function cancelOrder(Request $request)
    {
        $order = SalesOrder::where('OrderID', $request->orderID)->first();
        $salesOrder = SalesOrderAdmin::find($request->orderID);

        // cập nhật lại số lượng sách về kho
        $salesOrderDetails = $salesOrder->salesorderdetail;

        if ($salesOrderDetails != null) {
            foreach ($salesOrderDetails as $salesOrderDetail) {

                // Tìm kiếm sách tương ứng
                $book = Book::find($salesOrderDetail->BookID);
                $book->QuantityInStock +=  $salesOrderDetail->QuantitySold;
                $book->save();
            }
        }

        $order->salesOrderDetails()->delete();
        $order->delete();
        $userId = Session::get('user')->UserID;
        $addresses = ShippingAddress::where('UserID', $userId)->count();
        $shippingAddressList = ShippingAddress::where('UserID', $userId)->get();
        $order = SalesOrder::where('UserID', $userId)
            ->Where('OrderStatus', '!=', 'COMPLETED')
            ->get();
        if ($shippingAddressList) {
            return view("user.account-detail", ['numberAdd' => $addresses, 'shippingAddressList' => $shippingAddressList, 'orders' => $order]);
        }
        return view("user.account-detail", ['numberAdd' => $addresses, 'orders' => $order]);
    }
}
