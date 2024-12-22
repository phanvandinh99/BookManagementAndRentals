-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 23, 2024 at 05:57 PM
-- Server version: 10.6.17-MariaDB-cll-lve
-- PHP Version: 8.1.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `booksalesandrentals`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admin`
--

CREATE TABLE `Admin` (
  `AdminID` int(11) NOT NULL COMMENT 'Mã tài khoản Admin',
  `Email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `Password` varchar(255) DEFAULT NULL COMMENT 'Mật khẩu',
  `FullName` varchar(255) DEFAULT NULL COMMENT 'Họ và tên',
  `PhoneNumber` varchar(15) DEFAULT NULL COMMENT 'Số điện thoại'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về tài khoản Admin';

--
-- Dumping data for table `Admin`
--

INSERT INTO `Admin` (`AdminID`, `Email`, `Password`, `FullName`, `PhoneNumber`) VALUES
(16, 'admin@mail.com', '$2a$12$MbGTfsnvq5JkoBBJOgo1LOOSo7UMaTRZvmu54n9aBcl1zmaEOv2SC', 'Admin', '1122334455'),
(17, 'lxq.2309@gmail.com', '$2a$12$MbGTfsnvq5JkoBBJOgo1LOOSo7UMaTRZvmu54n9aBcl1zmaEOv2SC', 'Nhật', '0906144873');

-- --------------------------------------------------------

--
-- Stand-in structure for view `avgRatingBook`
-- (See below for the actual view)
--
CREATE TABLE `avgRatingBook` (
`BookID` int(11)
,`AVGRating` bigint(12)
);

-- --------------------------------------------------------

--
-- Table structure for table `Book`
--

CREATE TABLE `Book` (
  `BookID` int(11) NOT NULL COMMENT 'Mã sách',
  `BookTitle` varchar(255) DEFAULT NULL COMMENT 'Tên sách',
  `Author` varchar(255) DEFAULT NULL COMMENT 'Tên tác giả',
  `PublisherID` int(11) DEFAULT NULL COMMENT 'Mã nhà xuất bản',
  `CostPrice` decimal(10,2) DEFAULT NULL COMMENT 'Giá nhập (Giá ban đầu)',
  `SellingPrice` decimal(10,2) DEFAULT NULL COMMENT 'Giá bán',
  `QuantityInStock` int(11) DEFAULT NULL COMMENT 'Số lượng sách còn lại',
  `PageCount` int(11) DEFAULT NULL COMMENT 'Số trang',
  `Weight` decimal(6,2) DEFAULT NULL COMMENT 'Trọng lượng',
  `Avatar` varchar(255) DEFAULT NULL COMMENT 'Hình ảnh đại diện',
  `CoverStyle` tinyint(1) DEFAULT NULL COMMENT 'Hình thức bìa (0 - Bìa cứng, 1 - Bìa mềm)',
  `Size` varchar(255) DEFAULT NULL COMMENT 'Kích thước (dài x rộng x cao)',
  `YearPublished` int(11) DEFAULT NULL COMMENT 'Năm xuất bản',
  `Description` mediumtext DEFAULT NULL COMMENT 'Mô tả về sách',
  `SetID` int(11) DEFAULT NULL COMMENT 'Mã bộ sách (nếu có)',
  `ViewCount` int(11) DEFAULT 0 COMMENT 'Số lượt xem',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo',
  `CreatedBy` varchar(255) DEFAULT NULL COMMENT 'Người tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Người sửa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về sách';

-- --------------------------------------------------------


--
-- Table structure for table `BookGenre`
--

CREATE TABLE `BookGenre` (
  `BookID` int(11) NOT NULL COMMENT 'Mã sách',
  `GenreID` int(11) NOT NULL COMMENT 'Mã thể loại'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng liên kết sách với thể loại';

-- --------------------------------------------------------

--
-- Table structure for table `BookImage`
--

CREATE TABLE `BookImage` (
  `ImageID` int(11) NOT NULL COMMENT 'Mã hình ảnh',
  `BookID` int(11) DEFAULT NULL COMMENT 'Mã sách',
  `ImagePath` varchar(1000) DEFAULT NULL COMMENT 'Đường dẫn hình ảnh',
  `Description` mediumtext DEFAULT NULL COMMENT 'Mô tả về hình ảnh'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về hình ảnh của sách';

-- --------------------------------------------------------

--
-- Table structure for table `BookSet`
--

CREATE TABLE `BookSet` (
  `SetID` int(11) NOT NULL COMMENT 'Mã bộ sách',
  `SetTitle` varchar(255) DEFAULT NULL COMMENT 'Tên bộ sách',
  `SetNumber` int(11) DEFAULT NULL COMMENT 'Số tập',
  `SetAvatar` varchar(255) DEFAULT NULL COMMENT 'Hình đại diện của bộ sách',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo',
  `CreatedBy` varchar(255) DEFAULT NULL COMMENT 'Người tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Người sửa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về bộ sách của cuốn sách';

-- --------------------------------------------------------

CREATE TABLE `Category` (
  `CategoryID` int(11) NOT NULL COMMENT 'Mã danh mục',
  `CategoryName` varchar(255) DEFAULT NULL COMMENT 'Tên danh mục',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo',
  `CreatedBy` varchar(255) DEFAULT NULL COMMENT 'Người tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Người sửa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về danh mục sách';

-- --------------------------------------------------------

--
-- Table structure for table `Coupon`
--

CREATE TABLE `Coupon` (
  `CouponID` int(11) NOT NULL COMMENT 'Mã mã giảm giá',
  `CouponCode` varchar(255) DEFAULT NULL COMMENT 'Mã giảm giá',
  `DiscountAmount` decimal(4,2) DEFAULT NULL COMMENT 'Giảm giá (ví dụ: 0.7 -> Giảm 70%)',
  `ExpiryDate` date DEFAULT NULL COMMENT 'Ngày hết hạn',
  `IsUsed` tinyint(1) DEFAULT 0 COMMENT 'Đã sử dụng',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo',
  `CreatedBy` varchar(255) DEFAULT NULL COMMENT 'Người tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Người sửa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về mã giảm giá';

-- --------------------------------------------------------

--
-- Table structure for table `Genre`
--

CREATE TABLE `Genre` (
  `GenreID` int(11) NOT NULL COMMENT 'Mã thể loại',
  `GenreName` varchar(255) DEFAULT NULL COMMENT 'Tên thể loại',
  `CategoryID` int(11) DEFAULT NULL COMMENT 'Mã danh mục',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo',
  `CreatedBy` varchar(255) DEFAULT NULL COMMENT 'Người tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Người sửa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về thể loại sách';

-- --------------------------------------------------------

--
-- Stand-in structure for view `getListBookPriceAsc`
-- (See below for the actual view)
--
CREATE TABLE `getListBookPriceAsc` (
`BookID` int(11)
,`TotalSold` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `getListBookPriceDesc`
-- (See below for the actual view)
--
CREATE TABLE `getListBookPriceDesc` (
`BookID` int(11)
,`TotalSold` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `getListBookSoldDesc`
-- (See below for the actual view)
--
CREATE TABLE `getListBookSoldDesc` (
`BookID` int(11)
,`TotalSold` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Publisher`
--

CREATE TABLE `Publisher` (
  `PublisherID` int(11) NOT NULL COMMENT 'Mã nhà xuất bản',
  `PublisherName` varchar(255) DEFAULT NULL COMMENT 'Tên nhà xuất bản',
  `IsActive` tinyint(1) DEFAULT 1 COMMENT 'Còn hoạt động không ?',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo',
  `CreatedBy` varchar(255) DEFAULT NULL COMMENT 'Người tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Người sửa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về nhà xuất bản';

-- --------------------------------------------------------

--
-- Table structure for table `PurchaseOrder`
--

CREATE TABLE `PurchaseOrder` (
  `OrderID` int(11) NOT NULL COMMENT 'Mã hoá đơn nhập',
  `OrderDate` datetime DEFAULT NULL COMMENT 'Ngày nhập',
  `SupplierID` int(11) DEFAULT NULL COMMENT 'Mã nhà cung cấp',
  `TotalPrice` decimal(10,2) DEFAULT NULL COMMENT 'Tổng tiền'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về hoá đơn nhập';

-- --------------------------------------------------------
--
-- Table structure for table `PurchaseOrderDetail`
--

CREATE TABLE `PurchaseOrderDetail` (
  `OrderID` int(11) NOT NULL COMMENT 'Mã hoá đơn nhập',
  `BookID` int(11) NOT NULL COMMENT 'Mã sách',
  `QuantityReceived` int(11) DEFAULT NULL COMMENT 'Số lượng sách đã nhập',
  `Price` decimal(10,2) DEFAULT NULL COMMENT 'Giá tiền một cuốn sách',
  `SubTotal` decimal(10,2) DEFAULT NULL COMMENT 'Thành tiền'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về chi tiết hoá đơn nhập';

-- --------------------------------------------------------

--
-- Table structure for table `Review`
--

CREATE TABLE `Review` (
  `ReviewID` int(11) NOT NULL COMMENT 'Mã đánh giá',
  `BookID` int(11) DEFAULT NULL COMMENT 'Mã sách',
  `UserID` int(11) DEFAULT NULL COMMENT 'Mã người dùng',
  `Content` mediumtext DEFAULT NULL COMMENT 'Nội dung đánh giá',
  `Rating` int(11) DEFAULT NULL COMMENT 'Điểm đánh giá',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về đánh giá sách';

-- --------------------------------------------------------

--
-- Table structure for table `SalesOrder`
--

CREATE TABLE `SalesOrder` (
  `OrderID` int(11) NOT NULL COMMENT 'Mã hoá đơn bán',
  `OrderDate` datetime DEFAULT NULL COMMENT 'Ngày đặt hàng',
  `UserID` int(11) DEFAULT NULL COMMENT 'Mã người dùng',
  `OrderStatus` varchar(255) DEFAULT NULL COMMENT 'Trạng thái đơn hàng',
  `ShippingAddressID` int(11) DEFAULT NULL COMMENT 'Mã địa chỉ trong sổ địa chỉ',
  `ShippingFee` decimal(10,2) DEFAULT NULL COMMENT 'Phí vận chuyển',
  `OrderNote` mediumtext DEFAULT NULL COMMENT 'Ghi chú về đơn hàng',
  `Discount` decimal(4,2) DEFAULT NULL COMMENT 'Khuyến mại (Sau khi áp dụng voucher)',
  `TotalPrice` decimal(10,2) DEFAULT NULL COMMENT 'Tổng tiền'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về hoá đơn bán';

-- --------------------------------------------------------

--
-- Table structure for table `SalesOrderDetail`
--

CREATE TABLE `SalesOrderDetail` (
  `OrderID` int(11) NOT NULL COMMENT 'Mã hoá đơn bán',
  `BookID` int(11) NOT NULL COMMENT 'Mã sách',
  `QuantitySold` int(11) DEFAULT NULL COMMENT 'Số lượng bán',
  `Price` decimal(10,2) DEFAULT NULL COMMENT 'Giá sách',
  `SubTotal` decimal(10,2) DEFAULT NULL COMMENT 'Thành tiền'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về chi tiết hoá đơn bán';

-- --------------------------------------------------------

--
-- Table structure for table `ShippingAddress`
--

CREATE TABLE `ShippingAddress` (
  `AddressID` int(11) NOT NULL COMMENT 'Mã địa chỉ',
  `UserID` int(11) DEFAULT NULL COMMENT 'Mã người dùng',
  `FullName` varchar(255) DEFAULT NULL COMMENT 'Họ và tên',
  `City` varchar(255) DEFAULT NULL COMMENT 'Thành phố',
  `District` varchar(255) DEFAULT NULL COMMENT 'Quận',
  `Ward` varchar(255) DEFAULT NULL COMMENT 'Phường',
  `Address` varchar(255) DEFAULT NULL COMMENT 'Địa chỉ cụ thể',
  `PhoneNumber` varchar(15) DEFAULT NULL COMMENT 'Số điện thoại',
  `IsDefault` tinyint(1) DEFAULT 0 COMMENT 'Có phải địa chỉ mặc định không ?'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về sổ địa chỉ';

-- --------------------------------------------------------

--
-- Table structure for table `ShoppingCart`
--

CREATE TABLE `ShoppingCart` (
  `CartID` INT(11) NOT NULL COMMENT 'Mã giỏ hàng',
  `UserID` INT(11) DEFAULT NULL COMMENT 'Mã người dùng'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về giỏ hàng';

-- --------------------------------------------------------



--
-- Table structure for table `ShoppingCartDetail`
--

CREATE TABLE `ShoppingCartDetail` (
  `CartItemID` int(11) NOT NULL COMMENT 'Mã chi tiết giỏ hàng',
  `CartID` int(11) DEFAULT NULL COMMENT 'Mã giỏ hàng',
  `BookID` int(11) DEFAULT NULL COMMENT 'Mã sách',
  `Quantity` int(11) DEFAULT NULL COMMENT 'Số lượng'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về chi tiết giỏ hàng';

-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Table structure for table `Supplier`
--

CREATE TABLE `Supplier` (
  `SupplierID` int(11) NOT NULL COMMENT 'Mã nhà cung cấp',
  `SupplierName` varchar(255) DEFAULT NULL COMMENT 'Tên nhà cung cấp',
  `IsActive` tinyint(1) DEFAULT 1 COMMENT 'Còn hoạt động không ?',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo bản ghi',
  `CreatedBy` varchar(255) DEFAULT NULL COMMENT 'Người tạo bản ghi',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa bản ghi',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Người sửa bản ghi'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về nhà cung cấp';

-- --------------------------------------------------------


-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `UserID` int(11) NOT NULL COMMENT 'Mã người dùng',
  `UserName` varchar(255) DEFAULT NULL COMMENT 'Tên người dùng',
  `password` varchar(255) DEFAULT NULL COMMENT 'Mật khẩu',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `FirstName` varchar(255) DEFAULT NULL COMMENT 'Họ',
  `LastName` varchar(255) DEFAULT NULL COMMENT 'Tên',
  `Gender` varchar(10) DEFAULT NULL COMMENT 'Giới tính',
  `PhoneNumber` varchar(15) DEFAULT NULL COMMENT 'Số điện thoại',
  `DateOfBirth` date DEFAULT NULL COMMENT 'Ngày sinh',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ConfirmCode` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về người dùng';

--
-- Dumping data for table `User`
--

-- INSERT INTO `User` (`UserID`, `UserName`, `password`, `email`, `FirstName`, `LastName`, `Gender`, `PhoneNumber`, `DateOfBirth`, `CreatedDate`, `ModifiedDate`, `ConfirmCode`) VALUES
-- (1, 'nhat', '$2a$12$MbGTfsnvq5JkoBBJOgo1LOOSo7UMaTRZvmu54n9aBcl1zmaEOv2SC', 'nhat@example.com', 'Phan Văn', 'Nhật', NULL, '(662) 164-5483', NULL, NULL, '1999-01-01 00:04:32', NULL),
-- --------------------------------------------------------


-- --------------------------------------------------------

--
-- Structure for view `avgRatingBook`
--
DROP TABLE IF EXISTS `avgRatingBook`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avgRatingBook`  AS SELECT `b`.`BookID` AS `BookID`, ifnull(ceiling(avg(`r`.`Rating`)),0) AS `AVGRating` FROM (`Book` `b` left join `Review` `r` on(`b`.`BookID` = `r`.`BookID`)) GROUP BY `b`.`BookID` ;

-- --------------------------------------------------------

--
-- Structure for view `getListBookPriceAsc`
--
DROP TABLE IF EXISTS `getListBookPriceAsc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `getListBookPriceAsc`  AS SELECT `Book`.`BookID` AS `BookID`, sum(`SalesOrderDetail`.`QuantitySold`) AS `TotalSold` FROM (`Book` join `SalesOrderDetail` on(`Book`.`BookID` = `SalesOrderDetail`.`BookID`)) GROUP BY `Book`.`BookID` HAVING `TotalSold` > 0 ORDER BY sum(`SalesOrderDetail`.`QuantitySold`) DESC ;

-- --------------------------------------------------------

--
-- Structure for view `getListBookPriceDesc`
--
DROP TABLE IF EXISTS `getListBookPriceDesc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `getListBookPriceDesc`  AS SELECT `Book`.`BookID` AS `BookID`, coalesce(sum(`SalesOrderDetail`.`QuantitySold`),0) AS `TotalSold` FROM (`Book` left join `SalesOrderDetail` on(`Book`.`BookID` = `SalesOrderDetail`.`BookID`)) GROUP BY `Book`.`BookID` ORDER BY coalesce(sum(`SalesOrderDetail`.`QuantitySold`),0) DESC ;

-- --------------------------------------------------------

--
-- Structure for view `getListBookSoldDesc`
--
DROP TABLE IF EXISTS `getListBookSoldDesc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `getListBookSoldDesc`  AS SELECT `Book`.`BookID` AS `BookID`, coalesce(sum(`SalesOrderDetail`.`QuantitySold`),0) AS `TotalSold` FROM (`Book` left join `SalesOrderDetail` on(`Book`.`BookID` = `SalesOrderDetail`.`BookID`)) GROUP BY `Book`.`BookID` ORDER BY coalesce(sum(`SalesOrderDetail`.`QuantitySold`),0) DESC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`AdminID`);

--
-- Indexes for table `Book`
--
ALTER TABLE `Book`
  ADD PRIMARY KEY (`BookID`);

--
-- Indexes for table `BookSet`
--
ALTER TABLE `BookSet`
  ADD PRIMARY KEY (`SetID`);

--
-- Indexes for table `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Indexes for table `Coupon`
--
ALTER TABLE `Coupon`
  ADD PRIMARY KEY (`CouponID`);

--
-- Indexes for table `Genre`
--
ALTER TABLE `Genre`
  ADD PRIMARY KEY (`GenreID`);

--
-- Indexes for table `Publisher`
--
ALTER TABLE `Publisher`
  ADD PRIMARY KEY (`PublisherID`);

--
-- Indexes for table `PurchaseOrder`
--
ALTER TABLE `PurchaseOrder`
  ADD PRIMARY KEY (`OrderID`);

--
-- Indexes for table `Review`
--
ALTER TABLE `Review`
  ADD PRIMARY KEY (`ReviewID`);

--
-- Indexes for table `SalesOrder`
--
ALTER TABLE `SalesOrder`
  ADD PRIMARY KEY (`OrderID`);

--
-- Indexes for table `ShippingAddress`
--
ALTER TABLE `ShippingAddress`
  ADD PRIMARY KEY (`AddressID`);

--
-- Indexes for table `ShoppingCart`
--
ALTER TABLE `ShoppingCart`
  ADD PRIMARY KEY (`CartID`);

--
-- Indexes for table `ShoppingCartDetail`
--
ALTER TABLE `ShoppingCartDetail`
  ADD PRIMARY KEY (`CartItemID`);

--
-- Indexes for table `Supplier`
--
ALTER TABLE `Supplier`
  ADD PRIMARY KEY (`SupplierID`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Admin`
--
ALTER TABLE `Admin`
  MODIFY `AdminID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã tài khoản Admin', AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `Book`
--
ALTER TABLE `Book`
  MODIFY `BookID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã sách', AUTO_INCREMENT=10009;

--
-- AUTO_INCREMENT for table `BookSet`
--
ALTER TABLE `BookSet`
  MODIFY `SetID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã bộ sách', AUTO_INCREMENT=1009;

--
-- AUTO_INCREMENT for table `Category`
--
ALTER TABLE `Category`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã danh mục', AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Coupon`
--
ALTER TABLE `Coupon`
  MODIFY `CouponID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã mã giảm giá', AUTO_INCREMENT=1015;

--
-- AUTO_INCREMENT for table `Genre`
--
ALTER TABLE `Genre`
  MODIFY `GenreID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã thể loại', AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `Publisher`
--
ALTER TABLE `Publisher`
  MODIFY `PublisherID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã nhà xuất bản', AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `PurchaseOrder`
--
ALTER TABLE `PurchaseOrder`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã hoá đơn nhập', AUTO_INCREMENT=10025;

--
-- AUTO_INCREMENT for table `Review`
--
ALTER TABLE `Review`
  MODIFY `ReviewID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã đánh giá', AUTO_INCREMENT=20089;

--
-- AUTO_INCREMENT for table `SalesOrder`
--
ALTER TABLE `SalesOrder`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã hoá đơn bán', AUTO_INCREMENT=209;

--
-- AUTO_INCREMENT for table `ShippingAddress`
--
ALTER TABLE `ShippingAddress`
  MODIFY `AddressID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã địa chỉ', AUTO_INCREMENT=2024;

--
-- AUTO_INCREMENT for table `ShoppingCart`
--
ALTER TABLE `ShoppingCart`
  MODIFY `CartID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã giỏ hàng', AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT for table `ShoppingCartDetail`
--
ALTER TABLE `ShoppingCartDetail`
  MODIFY `CartItemID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã chi tiết giỏ hàng', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Supplier`
--
ALTER TABLE `Supplier`
  MODIFY `SupplierID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã nhà cung cấp', AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã người dùng', AUTO_INCREMENT=2045;
COMMIT;
