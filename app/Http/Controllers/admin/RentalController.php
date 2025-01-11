<?php

namespace App\Http\Controllers\admin;

use Carbon\Carbon;
use App\Models\admin\Rental;
use App\Models\admin\RentalDetail;
use App\Models\admin\User;
use App\Models\admin\Book;
use Illuminate\Http\Request;

class RentalController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        // Query chính cho Rental
        $rentals = Rental::query();

        // Tìm kiếm theo mã hóa đơn
        if ($request->has('search')) {
            $searchText = $request->input('search');
            $rentals->where('RentalID', '=', $searchText);
        }

        // Sắp xếp theo thứ tự
        $orderBy = $request->input('order', 'desc') === 'asc' ? 'asc' : 'desc';
        $rentals->orderBy('RentalID', $orderBy);

        // Phân trang
        $rentals = $rentals->paginate(10)->appends(['order' => $orderBy, 'search' => $request->input('search')]);

        return view('admin.rental.index', compact('rentals'))
            ->with('i', ($rentals->currentPage() - 1) * $rentals->perPage());
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $rental = new Rental();
        $users = User::all();
        return view('admin.rental.create', compact('rental', 'users'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // Xác thực dữ liệu
        $request->validate(Rental::$rules);

        // Tạo hoá đơn mượn
        $rental = new Rental();
        $rental->UserID = $request->input('UserID');
        $rental->DateCreated = Carbon::now(); // Ngày hiện tại
        $rental->Status = 0; // Chưa trả
        $rental->TotalBookCost = 0;
        $rental->TotalRentalPrice = 0;
        $rental->TotalPrice = 0;
        $rental->save();

        $totalBookCost = 0;
        $totalRentalPrice = 0;
        $totalPrice = 0;
        $errorMessages = [];

        // Lấy dữ liệu chi tiết sách từ form
        $bookIDs = $request->input('BookID', []);
        $endDates = $request->input('EndDate', []);

        // Lưu chi tiết hoá đơn thuê
        foreach ($bookIDs as $key => $bookID) {
            if (!empty($bookID)) {
                $book = Book::find($bookID);
                if ($book) {
                    // Kiểm tra số lượng sách trong kho
                    if ($book->QuantityInStock <= 0) {
                        // Nếu không còn sách trong kho, thêm lỗi vào mảng errorMessages
                        $errorMessages[] = "Sách '{$book->BookTitle}' không đủ để mượn.";
                        continue; // Bỏ qua sách này và tiếp tục với sách khác
                    }

                    // Lưu chi tiết hoá đơn thuê
                    $rentalDetail = new RentalDetail();
                    $rentalDetail->RentalID = $rental->RentalID;
                    $rentalDetail->BookID = $bookID;
                    $rentalDetail->BookCode = null;
                    $rentalDetail->Quantity = 1;
                    $rentalDetail->StartDate = $rental->DateCreated;
                    $rentalDetail->EndDate = $endDates[$key];
                    $rentalDetail->PaymentDate = null;
                    $rentalDetail->Status = 1;
                    $rentalDetail->save();

                    // Tính tổng giá trị
                    $totalBookCost += $book->SellingPrice;

                    // Tính số ngày thuê (sử dụng Carbon để tính số ngày giữa EndDate và StartDate)
                    $startDate = Carbon::parse($rental->DateCreated);
                    $endDate = Carbon::parse($endDates[$key]);
                    $rentalDays = $startDate->diffInDays($endDate);

                    // Giả sử giá thuê mỗi ngày là 2000
                    $totalRentalPrice += $rentalDays * 2000;

                    // Giảm số lượng sách trong kho
                    $book->QuantityInStock -= 1; // Giảm 1 cuốn sách
                    $book->save();
                }
            }
        }

        // Nếu có lỗi về số lượng sách, trả về thông báo lỗi
        if (count($errorMessages) > 0) {
            return redirect()->route('rental.index')->withErrors($errorMessages);
        }

        // Cập nhật tổng giá trị vào hoá đơn
        $totalPrice = $totalBookCost + $totalRentalPrice;
        $rental->TotalBookCost = $totalBookCost;
        $rental->TotalRentalPrice = $totalRentalPrice;
        $rental->TotalPrice = $totalPrice;
        $rental->save();

        return redirect()->route('rental.index')->with('success', 'Tạo hoá đơn mượn thành công!');
    }


    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $rental = Rental::with('rentalDetails.book')->find($id);

        if (!$rental) {
            return redirect()->back()->withErrors('Hóa đơn không tồn tại.');
        }

        $rentalDetails = $rental->rentalDetails; // Lấy danh sách chi tiết mượn sách

        return view('admin.rental.show', compact('rental', 'rentalDetails'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $rental = Rental::with('rentalDetails.book')->find($id);
        $users = User::all();

        return view('admin.rental.edit', compact('rental', 'users'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request $request
     * @param  \App\Models\admin\PurchaseOrder $purchaseOrder
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        // Xác thực dữ liệu
        $request->validate(Rental::$rules);

        // Tìm hóa đơn mượn
        $rental = Rental::find($id);
        if (!$rental) {
            return redirect()->back()->withErrors('Hóa đơn mượn không tồn tại.');
        }

        // Cập nhật thông tin hóa đơn
        $rental->UserID = $request->input('UserID');
        $rental->save();

        $totalBookCost = 0;
        $totalRentalPrice = 0;

        // Xóa các chi tiết cũ
        RentalDetail::where('RentalID', $id)->delete();

        // Lấy dữ liệu chi tiết sách từ form
        $bookIDs = $request->input('BookID', []);
        $endDates = $request->input('EndDate', []);
        $statuses = $request->input('Status', []);

        // Lưu các chi tiết mới
        foreach ($bookIDs as $key => $bookID) {
            if (!empty($bookID)) {
                $book = Book::find($bookID);
                if ($book) {
                    $rentalDetail = new RentalDetail();
                    $rentalDetail->RentalID = $rental->RentalID;
                    $rentalDetail->BookID = $bookID;
                    $rentalDetail->StartDate = $rental->DateCreated;
                    $rentalDetail->EndDate = $endDates[$key];
                    $rentalDetail->Status = isset($statuses[$key]) ? $statuses[$key] : 1;

                    // Gán PaymentDate nếu Status là "Đã trả" (0)
                    if ($rentalDetail->Status == 0) {
                        $rentalDetail->PaymentDate = Carbon::now(); // Ngày hiện tại
                        // Nếu sách đã trả (Status = 0), tăng số lượng sách trong kho
                        $book->QuantityInStock += 1;
                    } else {
                        $rentalDetail->PaymentDate = null; // Không có giá trị nếu chưa trả
                        // Nếu sách chưa trả (Status = 1), không thay đổi số lượng trong kho
                    }

                    $rentalDetail->save();

                    // Tính tổng giá trị
                    $totalBookCost += $book->SellingPrice;

                    // Tính số ngày thuê (sử dụng Carbon để tính số ngày giữa EndDate và StartDate)
                    $startDate = Carbon::parse($rental->DateCreated);
                    $endDate = Carbon::parse($endDates[$key]);
                    $rentalDays = $startDate->diffInDays($endDate);

                    // Giá thuê mỗi ngày
                    $totalRentalPrice += $rentalDays * 2000;

                    // Nếu sách chưa trả (Status = 1), giảm số lượng sách trong kho khi mượn
                    if ($rentalDetail->Status == 1) {
                        $book->QuantityInStock -= 1;
                    }
                    $book->save();
                }
            }
        }

        // Cập nhật tổng tiền
        $rental->TotalBookCost = $totalBookCost;
        $rental->TotalRentalPrice = $totalRentalPrice;
        $rental->TotalPrice = $totalBookCost + $totalRentalPrice;
        $rental->save();

        return redirect()->route('rental.show', $id)->with('success', 'Cập nhật hóa đơn mượn thành công!');
    }



    /**
     * @param int $id
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        // Tìm hóa đơn mượn
        $rental = Rental::find($id);
        if (!$rental) {
            return redirect()->route('rental.index')->withErrors('Hóa đơn mượn không tồn tại.');
        }

        // Lấy tất cả các chi tiết liên quan
        $rentalDetails = RentalDetail::where('RentalID', $id)->get();

        // Cập nhật số lượng sách trong kho nếu trạng thái là chưa trả (Status = 1)
        foreach ($rentalDetails as $rentalDetail) {
            $book = Book::find($rentalDetail->BookID);
            if ($book && $rentalDetail->Status == 1) {
                // Nếu sách chưa trả, tăng lại số lượng trong kho
                $book->QuantityInStock += 1;
                $book->save();
            }
        }

        // Xóa các chi tiết liên quan
        RentalDetail::where('RentalID', $id)->delete();

        // Xóa hóa đơn
        $rental->delete();

        return redirect()->route('rental.index')->with('success', 'Xóa hóa đơn mượn thành công!');
    }


    public function getAll()
    {
        return response()->json(Rental::with('rentalDetails.book')->get());
    }
}
