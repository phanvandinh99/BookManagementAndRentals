-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 23, 2024 lúc 05:53 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `booksalesandrentals`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admin`
--

CREATE TABLE `admin` (
  `AdminID` int(11) NOT NULL COMMENT 'Mã tài khoản Admin',
  `Email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `Password` varchar(255) DEFAULT NULL COMMENT 'Mật khẩu',
  `FullName` varchar(255) DEFAULT NULL COMMENT 'Họ và tên',
  `PhoneNumber` varchar(15) DEFAULT NULL COMMENT 'Số điện thoại'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về tài khoản Admin';

--
-- Đang đổ dữ liệu cho bảng `admin`
--

INSERT INTO `admin` (`AdminID`, `Email`, `Password`, `FullName`, `PhoneNumber`) VALUES
(16, 'admin@gmail.com', '$2a$12$MbGTfsnvq5JkoBBJOgo1LOOSo7UMaTRZvmu54n9aBcl1zmaEOv2SC', 'Admin', '1122334455'),
(17, 'nhat@gmail.com', '$2a$12$MbGTfsnvq5JkoBBJOgo1LOOSo7UMaTRZvmu54n9aBcl1zmaEOv2SC', 'Lê Sĩ Nhật', '0906144873');

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `avgratingbook`
-- (See below for the actual view)
--
CREATE TABLE `avgratingbook` (
`BookID` int(11)
,`AVGRating` bigint(12)
);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `book`
--

CREATE TABLE `book` (
  `BookID` int(11) NOT NULL COMMENT 'Mã sách',
  `BookTitle` varchar(255) DEFAULT NULL COMMENT 'Tên sách',
  `Author` varchar(255) DEFAULT NULL COMMENT 'Tên tác giả',
  `PublisherID` int(11) DEFAULT NULL COMMENT 'Mã nhà xuất bản',
  `CostPrice` decimal DEFAULT NULL COMMENT 'Giá nhập (Giá ban đầu)',
  `SellingPrice` decimal DEFAULT NULL COMMENT 'Giá bán',
  `QuantityInStock` int(11) DEFAULT NULL COMMENT 'Số lượng sách còn lại',
  `PageCount` int(11) DEFAULT NULL COMMENT 'Số trang',
  `Weight` decimal(6,2) DEFAULT NULL COMMENT 'Trọng lượng',
  `Avatar` varchar(255) DEFAULT NULL COMMENT 'Hình ảnh đại diện',
  `CoverStyle` tinyint(1) DEFAULT NULL COMMENT 'Hình thức bìa (0 - Bìa cứng, 1 - Bìa mềm)',
  `Rental` tinyint(1) DEFAULT 0 COMMENT 'Cho thuê (0 - Sách để bán, 1 - Sách cho thuê)',
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

--
-- Đang đổ dữ liệu cho bảng `book`
--

INSERT INTO `book` (`BookID`, `BookTitle`, `Author`, `PublisherID`, `CostPrice`, `SellingPrice`, `QuantityInStock`, `PageCount`, `Weight`, `Avatar`, `CoverStyle`, `Rental`,`Size`, `YearPublished`, `Description`, `SetID`, `ViewCount`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`) VALUES
(1, 'Người Bà Tài Giỏi Vùng Saga', 'Yoshichi Shimada', 1, 120000, 100000, 10, 216, 0.10, '/images/book/1734970935-Saga.webp', 1, 0, '18.5 x 13 cm', 2021, 'Hạnh phúc không phải là thứ được định đoạt bằng tiền. Hạnh phúc phải được định đoạt bằng tâm thế của mỗi chúng ta.', NULL, 0, '2024-12-23 23:22:15', 'Admin', '2024-12-23 23:22:15', NULL),
(2, '999 Lá Thư Gửi Cho Chính Mình', 'Miêu Công Tử', 2, 150000, 140000, 10, 232, 0.25, '/images/book/1734971099-999.jpg', 1, 0, '18 x 12.5 cm', 2021, '“999 lá thư gửi cho chính mình” – Mong bạn trở thành phiên bản hoàn hảo nhất. Cái gọi là vẻ đẹp nội tâm luôn luôn tốt hơn vẻ bề ngoài hào nhoáng, hy vọng bạn sẽ mãi luôn kiên cường, dũng cảm đứng ở nơi ánh sáng chiếu rọi, sống tốt một cuộc sống mà mình hằng mong ước.', NULL, 0, '2024-12-23 23:24:59', 'Admin', '2024-12-23 23:24:59', NULL),
(3, 'Có Một Ngày, Bố Mẹ Sẽ Già Đi', 'Nhiều Tác Giả', 3, 80000, 50000, 10, 124, 0.13, '/images/book/1734971257-BoMeGiaDi.webp', 1, 0, '18 x 13 x 0.5 cm', 2020, 'Càng lớn lên, những quyến luyến của chúng ta đối với bố mẹ càng ít. Khi đại bàng non có thể giương cánh, nó luôn hướng tới không trung, chứ không phải rúc vào đôi cánh bố mẹ.', NULL, 3, '2024-12-23 23:27:37', 'Admin', '2024-12-23 23:27:37', NULL),
(4, 'Kế Toán Vỉa Hè', 'Darrell Mullis, Judith Orloff', 4, 130000, 120000, 10, 327, 0.23, '/images/book/1734971487-KeToanViaHe.webp', 1, 0, '20.5 x 13 x 1.3 cm', 2023, 'Đã bao lần bạn cầm trên tay bảng báo cáo tài chính doanh nghiệp của mình, nhưng chẳng thể nào hiểu nổi?\r\n\r\nKế toán và tài chính là nỗi đau chung của rất nhiều doanh nghiệp nhỏ. Ngôn ngữ tài chính dường như là điều bí ẩn nhất của thế giới. Vô số tính toán và ý đồ được cài cắm sau các con số, mà thậm chí người kinh doanh nhiều năm cũng không thể nào bóc tách nổi.', NULL, 1, '2024-12-23 23:31:27', 'Admin', '2024-12-23 23:31:27', NULL),
(5, 'Để Con Được Ốm', 'Nguyễn Trí Đoàn, Uyên Bùi', 5, 100000, 90000, 10, 100, 0.03, '/images/book/1734971641-DeConDuocOm.webp', 0, 0, '18.5 x 13 cm', 2022, '“Để con được ốm cần có sự kiên nhẫn giải thích hay thuyết phục của bác sĩ cùng sự thông hiểu và hợp tác từ phía gia đình bé. Đôi khi, sự hợp tác và hiểu biết của phụ huynh còn quan trọng hơn nỗ lực (hay thời gian) của bác sĩ giải thích nữa. Quyết định không dùng kháng sinh hay ‘quay đầu lại’ hay không là tuỳ thuộc ở phụ huynh của các bé, tuỳ thuộc vào sự hiểu biết, kiên nhẫn và quan trọng nhất là sự hợp tác chặt chẽ với bác sĩ của con mình. Đã có nhiều trường hợp ‘quay đầu lại’ thành công, nhiều trường hợp không cần thuốc đắng vẫn dã tật thành công trong suốt 12 năm chúng tôi cùng nhau thực hành y khoa theo đúng chuẩn quốc tế: thực hành dựa trên chứng cứ y khoa tốt nhất cho bệnh nhi, dành thời gian để giải thích, tư vấn và theo dõi sát sao diễn tiến bệnh của bệnh nhi. Việc lo lắng là không thể tránh khỏi, tuy nhiên, sự lo lắng không giúp ích được gì cho bệnh của trẻ, chỉ có kiến thức chăm sóc bệnh đúng mới giúp ích cho trẻ. Và hẳn là các bé sẽ hạnh phúc biết bao khi được tôn trọng ‘quyền được bệnh’.   \r\n\r\n- BS. Trí Đoàn', NULL, 0, '2024-12-23 23:33:19', 'Admin', '2024-12-23 23:34:01', 'Admin'),
(6, 'Hoàng Tử Bé', 'Nguyễn Nhật Nam', 1, 60000, 50000, 10, 200, 0.18, '/images/book/1734971844-HoangTuBe.webp', 0, 0, '18 x 12.5 cm', 2022, 'Hoàng tử bé được xuất bản lần đầu năm 1943 của nhà văn, phi công người Pháp Antoine de Saint-exupéry là một trong những cuốn tiểu thuyết kinh điển nổi tiếng nhất mọi thời đại. Câu chuyện ngắn gọn về cuộc gặp gỡ diệu kỳ giữa viên phi công bị rơi máy bay và Hoàng tử bé giữa sa mạc Sa-ha-ra hoang vu. Hành tinh quê hương và các mối quan hệ của hoàng tử bé dần hé lộ: Tình bạn, tình yêu thương của Hoàng tử bé dành cho bông hồng duy nhất, tình cảm sâu sắc dành cho chú cáo.\r\n\r\nKhông những vậy, thông qua các cuộc gặp gỡ trong chuyến du ngoạn tới các hành tinh khác nhau của hoàng tử bé cũng chứa đựng triết lý nhân sinh sâu sắc về các kiểu người trong xã hội hiện đại.\r\n\r\nThật không ngoa khi khẳng định, mỗi câu chữ trong cuốn sách này đều đầy triết lý và mỗi người, mỗi lứa tuổi và mỗi hoàn cảnh khi đọc sẽ có những cảm nhận riêng.', NULL, 0, '2024-12-23 23:37:09', 'Admin', '2024-12-23 23:37:24', 'Admin'),
(7, 'Thư Cho Em', 'Hoàng Nam Tiến', 7, 105000, 100000, 10, 312, 0.29, '/images/book/1734972035-ThuChoEm.webp', 1, 0, '20.5 x 14 x 1.5 cm', 2024, 'Thư Cho Em\r\n\r\nCuốn sách này kể về mối tình vượt qua hai thế kỷ của thiếu tướng Hoàng Đan và vợ là đại biểu Quốc hội Nguyễn Thị An Vinh. Thương nhau từ thuở đôi mươi, nên duyên vợ chồng, họ cùng nhau đi qua những mốc lịch sử lớn lao của dân tộc: chiến thắng Điện Biên Phủ 1954, Khe Sanh 1968, Quảng Trị 1972, Sài Gòn 1975, biên giới phía Bắc 1979 và 1984.\r\n\r\nVị tướng trận đi khắp các chiến trường ác liệt, người vợ ở nhà nuôi con và phấn đấu sự nghiệp, thời gian họ ở bên nhau ít ỏi vô cùng. Vì thế họ gửi gắm tâm tình qua những lá thư băng qua bom đạn, vượt các biên giới. Những lá thư trở thành sợi dây buộc chặt tình yêu của hai con người.\r\n\r\nHoàng Nam Tiến đã viết thật xúc động về câu chuyện tình yêu tràn đầy trìu mến của ba mẹ, thông qua những lá thư ấy, không chỉ để lưu giữ ký ức riêng của gia đình, mà còn kể lại cho người đọc hôm nay về một thời đại vô cùng anh hùng và tuyệt vời lãng mạn.', NULL, 2, '2024-12-23 23:40:35', 'Admin', '2024-12-23 23:40:35', NULL),
(8, 'Người Thầy', 'Nguyễn Chí Vịnh', 7, 213000, 200000, 10, 497, 0.51, '/images/book/1734972168-NguoiThay.webp', 1, 0, '20.5 x 13 x 1.3 cm', 2023, 'Người Thầy\r\n\r\nNhân vật trung tâm trong cuốn sách là ông Ba Quốc, tức Thiếu tướng, Anh hùng Lực lượng vũ trang (LLVT) nhân dân Đặng Trần Đức, một nhà tình báo xuất sắc của tình báo quốc phòng Việt Nam, một cán bộ tình báo tài năng, hội tụ đầy đủ những phẩm chất của một điệp viên \"chui sâu, leo cao\" hoàn hảo, một nhà chỉ huy có tầm nhìn chiến lược, sắc sảo, quyết liệt và là một người thầy có cá tính đặc biệt, nghiêm khắc nhưng vô cùng nhân văn, sâu sắc.\r\n\r\nVới 500 trang khổ lớn, được bố cục thành 7 chương theo phong cách hiện đại, cuốn sách \"Người thầy\" không chỉ kể về những đóng góp quan trọng của ông Ba Quốc đối với ngành Tình báo quốc phòng mà còn nói về sự mất mát, hy sinh thầm lặng của cá nhân ông và gia đình, người thân. Cuốn sách đồng thời cũng đem đến cho bạn đọc những câu chuyện cuộc đời, những điệp vụ, chiến công của một số nhân vật nổi tiếng, những nhà tình báo lỗi lạc cũng như những người chỉ huy trực tiếp và những đồng đội “vào sinh ra tử” của tác giả.\r\n\r\nDưới góc nhìn của tác giả, Thiếu tướng Đặng Trần Đức là một người sẵn sàng hy sinh vì đất nước dưới sự lãnh đạo của Đảng, hết mình vì nhiệm vụ, nghiêm khắc về công việc nhưng cũng rất đời thường, quan tâm và sâu sát đối với thế hệ trẻ. Với tấm lòng kính trọng, cảm phục về người thầy của mình, Thượng tướng Nguyễn Chí Vịnh đã truyền lửa cho đoàn viên, thanh niên, thế hệ trẻ về tình yêu, lý tưởng cách mạng của Thiếu tướng Đặng Trần Đức, về niềm tin đối với thế hệ trẻ của lớp người đi trước.\r\n\r\nThượng tướng Nguyễn Chí Vịnh tâm sự đây là cuốn sách ông viết dành cho các bạn trẻ. Câu chuyện về Thiếu tướng Đặng Trần Đức cũng như những người đồng đội của ông, không chỉ là câu chuyện về riêng ông, về ngành tình báo quốc phòng, mà còn là những câu chuyện về thế hệ Hồ Chí Minh, không chỉ là lịch sử mà còn là giá trị của dân tộc, của đất nước phải giữ gìn. Đó cũng chính là lý do để cuốn sách ra mắt bạn đọc.\r\n\r\nTác giả cũng mong muốn cuốn sách “Người thầy” đến với bạn đọc nói chung, thế hệ trẻ nói riêng như một mảnh ghép rất nhỏ về quá khứ, qua đó để bạn đọc hiểu rõ hơn về giá trị của hòa bình.', NULL, 0, '2024-12-23 23:42:48', 'Admin', '2024-12-23 23:42:48', NULL),
(9, 'Thơ Xuân Diệu', 'Xuân Diệu', 1, 45000, 40000, 10, 180, 0.20, '/images/book/1734972361-XuanDieu.webp', 1, 1, '18 x 11 x 0.9 cm', 2023, 'Thơ Xuân Diệu\r\n\r\nTrong sự nghiệp sáng tác thơ văn của mình, Xuân Diệu được biết đến như là một nhà thơ lãng mạn trữ tình, “Nhà thơ mới nhất trong các nhà thơ mới” (Hoài Thanh), “Ông hoàng của thơ tình”.\r\n\r\nXuân Diệu là thành viên của Tự Lực Văn Đoàn và cũng đã là một trong những chủ soái của phong trào “Thơ Mới”. Tác phẩm tiêu biểu của ông ở giai đoạn này: Thơ Thơ (1938), Gửi hương cho gió (1945), truyện ngắn Phấn thông vàng (1939), Trường ca (1945).\r\n\r\nXuân Diệu tham gia ban chấp hành, nhiều năm là ủy viên thường vụ Hội Nhà văn Việt Nam. Từ đó, Xuân Diệu trở thành một trong những nhà thơ hàng đầu ca ngợi Cách mạng, một “dòng thơ công dân”. Bút pháp của ông chuyển biến phong phú về giọng vẻ: có giọng trầm hùng, tráng ca, có giọng chính luận, giọng thơ tự sự trữ tình. Tiêu biểu là: Ngọn quốc kỳ (1945), Một khối hồng (1964), Thanh ca (1982), Tuyển tập Xuân Diệu (1983).', NULL, 0, '2024-12-23 23:46:01', 'Admin', '2024-12-23 23:46:01', NULL),
(10, 'Chú Bé Mang Pyjama Sọc', 'John Boyne', 4, 67000, 60000, 10, 253, 0.28, '/images/book/1734972464-ChuBe.webp', 1, 1, '20.5 x 13 x 1.3 cm', 2023, 'Rất khó miêu tả câu chuyện về Chú bé mang pyjama sọc này. Thường thì chúng tôi vẫn tiết lộ vài chi tiết về cuốn sách trên bìa, nhưng trong trường hợp này chúng tôi nghĩ làm như vậy sẽ làm hỏng cảm giác đọc của bạn. Chúng tôi nghĩ điều quan trọng là bạn nên đọc mà không biết trước nó kể về điều gì.\r\nNếu bạn định bắt đầu đọc cuốn sách thật, bạn sẽ cùng được trải qua một hành trình với một cậu bé chín tuổi tên là Bruno (dù đây không hẳn là sách cho trẻ chín tuổi). Và chẳng sớm thì muộn bạn sẽ cùng Bruno đến một hàng rào. Những hàng rào như vậy vẫn tồn tại ở khắp nơi trên thế giới. Chúng tôi hy vọng không ai trong chúng ta phải vượt qua một hàng rào như vậy trong đời.\r\nNhận định\r\n\r\n“Một tuyệt tác sách nho nhỏ.” - Guardian\r\n\r\n“Một cuốn sách vương vấn khôn nguôi trong tâm trí người đọc.” - Times\r\n\r\n“Mạnh mẽ đến choáng váng.” - Carousel\r\n\r\n“Cuốn sách cứ nán lại trong tâm trí ta khá lâu. Một câu chuyện tinh tế, đơn giản một cách có tính toán và cảm động đến tận cùng. Dành cho bất kỳ lứa tuổi nào.” - Times\r\n\r\n\"Đây là những gì tiểu thuyết nên làm: giới thiệu ta đến với tâm trí của những người mà bình thường ta không dễ gì gặp được.\" - Guardian', NULL, 0, '2024-12-23 23:47:44', 'Admin', '2024-12-23 23:47:44', NULL),
(11, 'Có Hai Con Mèo Ngồi Bên Cửa Sổ', 'Nguyễn Nhật Ánh', 5, 87000, 80000, 10, 208, 0.20, '/images/book/1734972549-Meo.webp', 1, 1, '20.5 x 14 x 1.5 cm', 2023, 'Có Hai Con Mèo Ngồi Bên Cửa Sổ\r\n\r\nÓ HAI CON MÈO NGỒI BÊN CỬA SỔ là tác phẩm đầu tiên của nhà văn Nguyễn Nhật Ánh viết theo thể loại đồng thoại. Đặc biệt hơn nữa là viết về tình bạn của hai loài vốn là thù địch của nhau mèo và chuột. Đó là tình bạn giữa mèo Gấu và chuột Tí Hon.\r\n\r\nĐể biết tại sao mèo Gấu lại chơi thân với chuột Tí Hon, thì mời bạn hãy mở sách ra.\r\n\r\nCuốn truyện mỏng mảnh vừa phải, hình vẽ của họa sĩ Hoàng Tường sinh động đến từng nét nũng nịu hay kiêu căng của nàng mèo người yêu mèo Gấu, câu chuyện thì hấp dẫn duyên dáng điểm những bài thơ tình lãng mạn nao lòng song đọc to lên thì khiến cười hinh hích…\r\n\r\nBạn hãy đọc nhé, để thấy, Nguyễn Nhật Ánh đã viết truyện đồng thoại theo cái cách của riêng mình độc đáo như thế nào.', NULL, 0, '2024-12-23 23:49:09', 'Admin', '2024-12-23 23:49:09', NULL),
(12, 'Chính Sách Tiền Tệ Thế Kỷ 21', 'Phan Văn Dũng', 6, 260000, 250000, 10, 536, 0.55, '/images/book/1734972686-TienTe.webp', 1, 1, '18 x 11 x 0.9 cm', 2023, 'Chính Sách Tiền Tệ Thế Kỷ 21\r\n\r\nCuốn sách đầu tiên bàn về lịch sử chống lạm phát & khủng hoảng của Cục Dự trữ Liên bang Hoa Kỳ\r\n\r\nChính sách tiền tệ thế kỷ 21 xem xét Fed – cơ quan quản lý chính sách tiền tệ Mỹ của hiện tại và tương lai chủ yếu thông qua lăng kính lịch sử, nhằm giúp người đọc hiểu được Fed đã làm thế nào để đạt được vị trí như ngày nay, học được gì từ những thách thức đa dạng phải đối mặt, và có thể phát triển như thế nào trong tương lai.\r\n\r\nĐược viết bởi Ben S. Bernanke – người giữ chức Chủ tịch Fed từ năm 2006 đến năm 2014, cuốn sách mang đến cái nhìn tổng quan về quá trình hoạch định chính sách của Fed trong 70 năm qua, cho thấy những thay đổi trong nền kinh tế đã thúc đẩy những đổi mới của Fed như thế nào cũng như những thách thức mới mà Fed phải đối mặt, bao gồm: lạm phát quay trở lại, tiền điện tử, rủi ro bất ổn tài chính gia tăng và các mối đe dọa đối với tính độc lập của tổ chức này.\r\n\r\nNgoài việc giải thích các công cụ hoạch định chính sách mới của hệ thống ngân hàng trung ương, cuốn sách còn kể về những khoảnh khắc kịch tính mà với đó, các quyết định của Fed dưới triết lý của những người từng chèo lái tổ chức này - đã tạo nên nhiều tác động đáng kể. Sách gồm 4 phần:\r\n\r\n1. Sự tăng giảm của lạm phát: bàn về các chiến lược ứng phó của Fed trước Đại Lạm Phát (thập niên 60-80 thế kỷ 20) và giai đoạn bùng nổ 1990.\r\n\r\n2. Khủng hoảng tài chính toàn cầu và Đại Suy thoái: bàn về những thách thức của thiên niên kỷ mới, trong đó có suy thoái 2001, giảm phát 2003, Khủng hoảng tài chính toàn cầu (2007-2008) và Đại Suy thoái (2009).', NULL, 0, '2024-12-23 23:51:26', 'Admin', '2024-12-23 23:51:26', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bookgenre`
--

CREATE TABLE `bookgenre` (
  `BookID` int(11) NOT NULL COMMENT 'Mã sách',
  `GenreID` int(11) NOT NULL COMMENT 'Mã thể loại'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng liên kết sách với thể loại';

--
-- Đang đổ dữ liệu cho bảng `bookgenre`
--

INSERT INTO `bookgenre` (`BookID`, `GenreID`) VALUES
(1, 1),
(2, 1),
(3, 7),
(3, 10),
(3, 12),
(3, 15),
(4, 5),
(4, 6),
(4, 7),
(4, 8),
(4, 14),
(5, 9),
(5, 13),
(5, 14),
(5, 16),
(6, 2),
(6, 9),
(6, 14),
(6, 17),
(6, 19),
(7, 1),
(7, 3),
(7, 4),
(7, 10),
(7, 19),
(7, 22),
(8, 1),
(8, 4),
(8, 5),
(8, 12),
(8, 15),
(8, 22),
(9, 4),
(9, 12),
(9, 15),
(9, 23),
(10, 1),
(10, 2),
(10, 14),
(10, 17),
(10, 20),
(11, 1),
(11, 2),
(11, 17),
(12, 5),
(12, 6),
(12, 7),
(12, 8),
(12, 23);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bookimage`
--

CREATE TABLE `bookimage` (
  `ImageID` int(11) NOT NULL COMMENT 'Mã ảnh sách',
  `BookID` int(11) DEFAULT NULL COMMENT 'Mã sách',
  `ImagePath` varchar(1000) DEFAULT NULL COMMENT 'Đường dẫn hình ảnh',
  `Description` mediumtext DEFAULT NULL COMMENT 'Mô tả về hình ảnh'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về hình ảnh của sách';

--
-- Đang đổ dữ liệu cho bảng `bookimage`
--

INSERT INTO `bookimage` (`ImageID`, `BookID`, `ImagePath`, `Description`) VALUES
(1, 1, '/images/book/images/1734970935-Saga2.webp', 'Người Bà Tài Giỏi Vùng Saga-1734970935'),
(2, 1, '/images/book/images/1734970935-Saga3.webp', 'Người Bà Tài Giỏi Vùng Saga-1734970935'),
(3, 2, '/images/book/images/1734971099-999_1.jpg', '999 Lá Thư Gửi Cho Chính Mình-1734971099'),
(4, 2, '/images/book/images/1734971099-999_2.webp', '999 Lá Thư Gửi Cho Chính Mình-1734971099'),
(5, 2, '/images/book/images/1734971099-999_3.webp', '999 Lá Thư Gửi Cho Chính Mình-1734971099'),
(6, 3, '/images/book/images/1734971257-BoMeGiaDi_1.webp', 'Có Một Ngày, Bố Mẹ Sẽ Già Đi-1734971257'),
(7, 4, '/images/book/images/1734971487-KeToanViaHe_1.webp', 'Kế Toán Vỉa Hè-1734971487'),
(8, 4, '/images/book/images/1734971487-KeToanViaHe_2.webp', 'Kế Toán Vỉa Hè-1734971487'),
(9, 4, '/images/book/images/1734971487-KeToanViaHe_3.webp', 'Kế Toán Vỉa Hè-1734971487'),
(10, 6, '/images/book/images/1734971829-HoangTuBe_1.webp', 'Hoàng Tử Bé-1734971829'),
(11, 6, '/images/book/images/1734971829-HoangTuBe_2.webp', 'Hoàng Tử Bé-1734971829'),
(12, 6, '/images/book/images/1734971829-HoangTuBe_3.webp', 'Hoàng Tử Bé-1734971829'),
(13, 7, '/images/book/images/1734972035-ThuChoEm_1.webp', 'Thư Cho Em-1734972035'),
(14, 7, '/images/book/images/1734972035-ThuChoEm_2.webp', 'Thư Cho Em-1734972035'),
(15, 9, '/images/book/images/1734972361-XuanDieu_1.webp', 'Thơ Xuân Diệu-1734972361'),
(16, 9, '/images/book/images/1734972361-XuanDieu_2.webp', 'Thơ Xuân Diệu-1734972361'),
(17, 12, '/images/book/images/1734972686-TienTe_1.webp', 'Chính Sách Tiền Tệ Thế Kỷ 21-1734972686');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bookset`
--

CREATE TABLE `bookset` (
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

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `CategoryID` int(11) NOT NULL COMMENT 'Mã danh mục',
  `CategoryName` varchar(255) DEFAULT NULL COMMENT 'Tên danh mục',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo',
  `CreatedBy` varchar(255) DEFAULT NULL COMMENT 'Người tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Người sửa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về danh mục sách';

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`CategoryID`, `CategoryName`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`) VALUES
(1, 'Văn Học', '2024-12-23 22:52:36', 'Admin', '2024-12-23 22:52:36', NULL),
(2, 'Kinh Tế', '2024-12-23 22:52:43', 'Admin', '2024-12-23 22:52:43', NULL),
(3, 'Tâm Lý - Kỹ Năng Sống', '2024-12-23 22:53:04', 'Admin', '2024-12-23 22:53:04', NULL),
(4, 'Nuôi Dạy Con', '2024-12-23 22:53:25', 'Admin', '2024-12-23 22:53:25', NULL),
(5, 'Sách Thiếu Nhi', '2024-12-23 22:53:31', 'Admin', '2024-12-23 22:53:31', NULL),
(6, 'Tiểu Sử - Hồi Ký', '2024-12-23 22:54:06', 'Admin', '2024-12-23 22:54:06', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `coupon`
--

CREATE TABLE `coupon` (
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
-- Cấu trúc bảng cho bảng `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `genre`
--

CREATE TABLE `genre` (
  `GenreID` int(11) NOT NULL COMMENT 'Mã thể loại',
  `GenreName` varchar(255) DEFAULT NULL COMMENT 'Tên thể loại',
  `CategoryID` int(11) DEFAULT NULL COMMENT 'Mã danh mục',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo',
  `CreatedBy` varchar(255) DEFAULT NULL COMMENT 'Người tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Người sửa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về thể loại sách';

--
-- Đang đổ dữ liệu cho bảng `genre`
--

INSERT INTO `genre` (`GenreID`, `GenreName`, `CategoryID`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`) VALUES
(1, 'Tiểu thuyết', 1, '2024-12-23 22:55:58', 'Admin', '2024-12-23 22:55:58', NULL),
(2, 'Truyện Ngắn', 1, '2024-12-23 22:56:20', 'Admin', '2024-12-23 22:56:20', NULL),
(3, 'Ngôn Tình', 1, '2024-12-23 22:56:30', 'Admin', '2024-12-23 22:56:30', NULL),
(4, 'Thơ Ca', 1, '2024-12-23 22:57:08', 'Admin', '2024-12-23 22:57:08', NULL),
(5, 'Chính Trị - Lãnh Đạo', 2, '2024-12-23 22:57:33', 'Admin', '2024-12-23 22:57:33', NULL),
(6, 'Bài Học Kinh Doanh', 2, '2024-12-23 22:58:35', 'Admin', '2024-12-23 22:58:35', NULL),
(7, 'Khởi Nghiệp - Làm Giàu', 2, '2024-12-23 22:58:49', 'Admin', '2024-12-23 22:58:49', NULL),
(8, 'Ngoại Thương', 2, '2024-12-23 22:59:06', 'Admin', '2024-12-23 22:59:06', NULL),
(9, 'Kỹ Năng Sống', 3, '2024-12-23 22:59:20', 'Admin', '2024-12-23 22:59:20', NULL),
(10, 'Tâm Lý', 3, '2024-12-23 22:59:33', 'Admin', '2024-12-23 22:59:33', NULL),
(11, 'Sách Cho Tuổi Teen', 3, '2024-12-23 22:59:45', 'Admin', '2024-12-23 22:59:45', NULL),
(12, 'Rèn Luyện Nhân Cách', 3, '2024-12-23 22:59:59', 'Admin', '2024-12-23 22:59:59', NULL),
(13, 'Cẩm Nang Làm Mẹ', 4, '2024-12-23 23:00:45', 'Admin', '2024-12-23 23:00:45', NULL),
(14, 'Phát Triển Kỹ Năng', 4, '2024-12-23 23:01:00', 'Admin', '2024-12-23 23:01:00', NULL),
(15, 'Phương Pháp Giáo Dục', 4, '2024-12-23 23:01:16', 'Admin', '2024-12-23 23:01:16', NULL),
(16, 'Dành Cho Mẹ Bầu', 4, '2024-12-23 23:01:33', 'Admin', '2024-12-23 23:01:33', NULL),
(17, 'Truyện Thiếu Nhi', 5, '2024-12-23 23:02:03', 'Admin', '2024-12-23 23:02:03', NULL),
(18, 'Tô Màu - Luyện Chữ', 5, '2024-12-23 23:02:20', 'Admin', '2024-12-23 23:02:20', NULL),
(19, 'Sách Nói', 5, '2024-12-23 23:02:31', 'Admin', '2024-12-23 23:02:31', NULL),
(20, 'Từ Điển Thiếu Nhi', 5, '2024-12-23 23:02:43', 'Admin', '2024-12-23 23:02:43', NULL),
(21, 'Lịch Sử', 6, '2024-12-23 23:16:11', 'Admin', '2024-12-23 23:16:11', NULL),
(22, 'Câu Chuyện Cuộc Đời', 6, '2024-12-23 23:16:42', 'Admin', '2024-12-23 23:16:42', NULL),
(23, 'Nghệ Thuật', 6, '2024-12-23 23:16:59', 'Admin', '2024-12-23 23:16:59', NULL),
(24, 'Thể Thao', 6, '2024-12-23 23:17:14', 'Admin', '2024-12-23 23:17:14', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `getlistbookpriceasc`
-- (See below for the actual view)
--
CREATE TABLE `getlistbookpriceasc` (
`BookID` int(11)
,`TotalSold` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `getlistbookpricedesc`
-- (See below for the actual view)
--
CREATE TABLE `getlistbookpricedesc` (
`BookID` int(11)
,`TotalSold` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `getlistbooksolddesc`
-- (See below for the actual view)
--
CREATE TABLE `getlistbooksolddesc` (
`BookID` int(11)
,`TotalSold` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2024_10_12_000000_create_users_table', 1),
(3, '2024_10_12_100000_create_password_reset_tokens_table', 1),
(4, '2024_11_17_000000_create_failed_jobs_table', 1),
(5, '2024_12_20_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `publisher`
--

CREATE TABLE `publisher` (
  `PublisherID` int(11) NOT NULL COMMENT 'Mã nhà xuất bản',
  `PublisherName` varchar(255) DEFAULT NULL COMMENT 'Tên nhà xuất bản',
  `IsActive` tinyint(1) DEFAULT 1 COMMENT 'Còn hoạt động không ?',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo',
  `CreatedBy` varchar(255) DEFAULT NULL COMMENT 'Người tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Người sửa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về nhà xuất bản';

--
-- Đang đổ dữ liệu cho bảng `publisher`
--

INSERT INTO `publisher` (`PublisherID`, `PublisherName`, `IsActive`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`) VALUES
(1, 'NXB Tuổi Trẻ', 1, '2024-12-23 22:45:09', 'Admin', '2024-12-23 22:45:09', NULL),
(2, 'NXB Kim Đồng', 1, '2024-12-23 22:45:25', 'Admin', '2024-12-23 22:45:25', NULL),
(3, 'NXB Giáo Dục Việt Nam', 1, '2024-12-23 22:45:47', 'Admin', '2024-12-23 22:45:47', NULL),
(4, 'NXB Lao Động', 1, '2024-12-23 22:46:00', 'Admin', '2024-12-23 22:46:00', NULL),
(5, 'NXB Hội Nhà Văn', 1, '2024-12-23 22:46:19', 'Admin', '2024-12-23 22:46:19', NULL),
(6, 'NXB Nhã Nam', 1, '2024-12-23 22:46:36', 'Admin', '2024-12-23 22:46:36', NULL),
(7, 'NXB Đông A', 1, '2024-12-23 22:46:47', 'Admin', '2024-12-23 22:46:47', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `purchaseorder`
--

CREATE TABLE `purchaseorder` (
  `OrderID` int(11) NOT NULL COMMENT 'Mã hoá đơn nhập',
  `OrderDate` datetime DEFAULT NULL COMMENT 'Ngày nhập',
  `SupplierID` int(11) DEFAULT NULL COMMENT 'Mã nhà cung cấp',
  `TotalPrice` decimal DEFAULT NULL COMMENT 'Tổng tiền'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về hoá đơn nhập';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `purchaseorderdetail`
--

CREATE TABLE `purchaseorderdetail` (
  `OrderID` int(11) NOT NULL COMMENT 'Mã hoá đơn nhập',
  `BookID` int(11) NOT NULL COMMENT 'Mã sách',
  `QuantityReceived` int(11) DEFAULT NULL COMMENT 'Số lượng sách đã nhập',
  `Price` decimal DEFAULT NULL COMMENT 'Giá tiền một cuốn sách',
  `SubTotal` decimal DEFAULT NULL COMMENT 'Thành tiền'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về chi tiết hoá đơn nhập';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `review`
--

CREATE TABLE `review` (
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
-- Cấu trúc bảng cho bảng `salesorder`
--

CREATE TABLE `salesorder` (
  `OrderID` int(11) NOT NULL COMMENT 'Mã hoá đơn bán',
  `OrderDate` datetime DEFAULT NULL COMMENT 'Ngày đặt hàng',
  `UserID` int(11) DEFAULT NULL COMMENT 'Mã người dùng',
  `OrderStatus` varchar(255) DEFAULT NULL COMMENT 'Trạng thái đơn hàng',
  `ShippingAddressID` int(11) DEFAULT NULL COMMENT 'Mã địa chỉ trong sổ địa chỉ',
  `ShippingFee` decimal DEFAULT NULL COMMENT 'Phí vận chuyển',
  `OrderNote` mediumtext DEFAULT NULL COMMENT 'Ghi chú về đơn hàng',
  `Discount` decimal(4,2) DEFAULT NULL COMMENT 'Khuyến mại (Sau khi áp dụng voucher)',
  `PaymentType` ENUM('Online', 'Cash')  DEFAULT 'Cash' COMMENT 'Hình thức thanh toán (Online hoặc tiền mặt)',
  `TotalPrice` decimal DEFAULT NULL COMMENT 'Tổng tiền'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về hoá đơn bán';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `salesorderdetail`
--

CREATE TABLE `salesorderdetail` (
  `OrderID` int(11) NOT NULL COMMENT 'Mã hoá đơn bán',
  `BookID` int(11) NOT NULL COMMENT 'Mã sách',
  `QuantitySold` int(11) DEFAULT NULL COMMENT 'Số lượng bán',
  `Price` decimal DEFAULT NULL COMMENT 'Giá sách',
  `SubTotal` decimal DEFAULT NULL COMMENT 'Thành tiền'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về chi tiết hoá đơn bán';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `shippingaddress`
--

CREATE TABLE `shippingaddress` (
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
-- Cấu trúc bảng cho bảng `shoppingcart`
--

CREATE TABLE `shoppingcart` (
  `CartID` int(11) NOT NULL COMMENT 'Mã giỏ hàng',
  `UserID` int(11) DEFAULT NULL COMMENT 'Mã người dùng'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về giỏ hàng';

--
-- Đang đổ dữ liệu cho bảng `shoppingcart`
--

INSERT INTO `shoppingcart` (`CartID`, `UserID`) VALUES
(1, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rental`
--

CREATE TABLE `rental` (
  `RentalID` int(11) NOT NULL COMMENT 'Mã thuê sách',
  `UserID` int(11) DEFAULT NULL COMMENT 'Mã người dùng',
  `DateCreated` DATETIME DEFAULT NULL COMMENT 'Ngày Tạo',
  `Status` tinyint(1) DEFAULT 0 COMMENT 'Đã trả hết/ chưa trả',
  `TotalBookCost` decimal DEFAULT NULL COMMENT 'Tổng tiền sách',
  `TotalRentalPrice` decimal DEFAULT NULL COMMENT 'Tổng giá thuê',
  `TotalPrice` decimal DEFAULT NULL COMMENT 'Tổng tiền'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về thuê sách';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `shoppingcartdetail`
--

CREATE TABLE `shoppingcartdetail` (
  `CartItemID` int(11) NOT NULL COMMENT 'Mã chi tiết giỏ hàng',
  `CartID` int(11) DEFAULT NULL COMMENT 'Mã giỏ hàng',
  `BookID` int(11) DEFAULT NULL COMMENT 'Mã sách',
  `Quantity` int(11) DEFAULT NULL COMMENT 'Số lượng'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về chi tiết giỏ hàng';

--
-- Đang đổ dữ liệu cho bảng `shoppingcartdetail`
--

INSERT INTO `shoppingcartdetail` (`CartItemID`, `CartID`, `BookID`, `Quantity`) VALUES
(1, 2, 3, 1),
(2, 1, 3, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rentaldetail`
--

CREATE TABLE `rentaldetail` (
  `RentalDetailID` int(11) NOT NULL COMMENT 'Mã chi tiết thuê sách',
  `RentalID` int(11) DEFAULT NULL COMMENT 'Mã thuê sách',
  `BookID` int(11) DEFAULT NULL COMMENT 'Mã sách',
  `BookCode` int(11) DEFAULT NULL COMMENT 'Mã code sách',
  `Quantity` int(11) DEFAULT NULL COMMENT 'Số lượng',
  `StartDate` DATETIME DEFAULT NULL COMMENT 'Ngày bắt đầu mượn',
  `EndDate` DATETIME DEFAULT NULL COMMENT 'Ngày kết thúc mượn',
  `PaymentDate` DATETIME DEFAULT NULL COMMENT 'Ngày kết thúc mượn',
  `Status` tinyint(1) DEFAULT 0 COMMENT '0 Đã trả / 1 chưa trả'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về chi tiết thuê sách';

--
-- Đang đổ dữ liệu cho bảng `renderdetail`
--

INSERT INTO `rentaldetail` (`RentalDetailID`, `RentalID`, `BookID`, `Quantity`, `StartDate`, `EndDate`) VALUES
(1, 2, 3, 1, '2025-01-01', '2025-01-15'),
(2, 1, 3, 1, '2025-02-01', '2025-02-15');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `supplier`
--

CREATE TABLE `supplier` (
  `SupplierID` int(11) NOT NULL COMMENT 'Mã nhà cung cấp',
  `SupplierName` varchar(255) DEFAULT NULL COMMENT 'Tên nhà cung cấp',
  `IsActive` tinyint(1) DEFAULT 1 COMMENT 'Còn hoạt động không ?',
  `CreatedDate` datetime DEFAULT current_timestamp() COMMENT 'Ngày tạo bản ghi',
  `CreatedBy` varchar(255) DEFAULT NULL COMMENT 'Người tạo bản ghi',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa bản ghi',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Người sửa bản ghi'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci COMMENT='Bảng lưu trữ thông tin về nhà cung cấp';

--
-- Đang đổ dữ liệu cho bảng `supplier`
--

INSERT INTO `supplier` (`SupplierID`, `SupplierName`, `IsActive`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`) VALUES
(1, 'Kim Đồng', 1, '2024-12-23 22:47:43', 'Admin', '2024-12-23 22:47:43', NULL),
(2, 'FAHASA', 1, '2024-12-23 22:51:06', 'Admin', '2024-12-23 22:51:06', NULL),
(3, 'Book365', 1, '2024-12-23 22:51:12', 'Admin', '2024-12-23 22:51:12', NULL),
(4, 'Thebookland', 1, '2024-12-23 22:51:17', 'Admin', '2024-12-23 22:51:17', NULL),
(5, 'Alpha Books', 1, '2024-12-23 22:51:26', 'Admin', '2024-12-23 22:51:26', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
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

INSERT INTO `user` (`UserID`, `UserName`, `password`, `email`, `FirstName`, `LastName`, `Gender`, `PhoneNumber`, `DateOfBirth`, `CreatedDate`, `ModifiedDate`, `ConfirmCode`) 
VALUES ( 1, 'nhat', '$2a$12$MbGTfsnvq5JkoBBJOgo1LOOSo7UMaTRZvmu54n9aBcl1zmaEOv2SC', 'nhat@gmail.com', 'Lê Sĩ', 'Nhật', 'Nam', '1234567890', '2000-01-01', CURRENT_TIMESTAMP, NULL, 'Abc123456');
INSERT INTO `user` (`UserID`, `UserName`, `password`, `email`, `FirstName`, `LastName`, `Gender`, `PhoneNumber`, `DateOfBirth`, `CreatedDate`, `ModifiedDate`, `ConfirmCode`) 
VALUES ( 2, 'hung', '$2a$12$MbGTfsnvq5JkoBBJOgo1LOOSo7UMaTRZvmu54n9aBcl1zmaEOv2SC', 'hung@gmail.com', 'Nguyễn Phi', 'Hùng', 'Nam', '1234567899', '2000-12-11', CURRENT_TIMESTAMP, NULL, 'Abc123456');
INSERT INTO `user` (`UserID`, `UserName`, `password`, `email`, `FirstName`, `LastName`, `Gender`, `PhoneNumber`, `DateOfBirth`, `CreatedDate`, `ModifiedDate`, `ConfirmCode`) 
VALUES ( 3, 'vien', '$2a$12$MbGTfsnvq5JkoBBJOgo1LOOSo7UMaTRZvmu54n9aBcl1zmaEOv2SC', 'vien@gmail.com', 'Nguyễn Minh', 'Viên', 'Nam', '1234567899', '2000-06-03', CURRENT_TIMESTAMP, NULL, 'Abc123456');
-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `avgratingbook`
--
DROP TABLE IF EXISTS `avgratingbook`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avgratingbook`  AS SELECT `b`.`BookID` AS `BookID`, ifnull(ceiling(avg(`r`.`Rating`)),0) AS `AVGRating` FROM (`book` `b` left join `review` `r` on(`b`.`BookID` = `r`.`BookID`)) GROUP BY `b`.`BookID` ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `getlistbookpriceasc`
--
DROP TABLE IF EXISTS `getlistbookpriceasc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `getlistbookpriceasc`  AS SELECT `book`.`BookID` AS `BookID`, sum(`salesorderdetail`.`QuantitySold`) AS `TotalSold` FROM (`book` join `salesorderdetail` on(`book`.`BookID` = `salesorderdetail`.`BookID`)) GROUP BY `book`.`BookID` HAVING `TotalSold` > 0 ORDER BY sum(`salesorderdetail`.`QuantitySold`) DESC ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `getlistbookpricedesc`
--
DROP TABLE IF EXISTS `getlistbookpricedesc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `getlistbookpricedesc`  AS SELECT `book`.`BookID` AS `BookID`, coalesce(sum(`salesorderdetail`.`QuantitySold`),0) AS `TotalSold` FROM (`book` left join `salesorderdetail` on(`book`.`BookID` = `salesorderdetail`.`BookID`)) GROUP BY `book`.`BookID` ORDER BY coalesce(sum(`salesorderdetail`.`QuantitySold`),0) DESC ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `getlistbooksolddesc`
--
DROP TABLE IF EXISTS `getlistbooksolddesc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `getlistbooksolddesc`  AS SELECT `book`.`BookID` AS `BookID`, coalesce(sum(`salesorderdetail`.`QuantitySold`),0) AS `TotalSold` FROM (`book` left join `salesorderdetail` on(`book`.`BookID` = `salesorderdetail`.`BookID`)) GROUP BY `book`.`BookID` ORDER BY coalesce(sum(`salesorderdetail`.`QuantitySold`),0) DESC ;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AdminID`);

--
-- Chỉ mục cho bảng `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`BookID`);

--
-- Chỉ mục cho bảng `bookimage`
--
ALTER TABLE `bookimage`
  ADD PRIMARY KEY (`ImageID`);

--
-- Chỉ mục cho bảng `bookset`
--
ALTER TABLE `bookset`
  ADD PRIMARY KEY (`SetID`);

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Chỉ mục cho bảng `coupon`
--
ALTER TABLE `coupon`
  ADD PRIMARY KEY (`CouponID`);

--
-- Chỉ mục cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Chỉ mục cho bảng `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`GenreID`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Chỉ mục cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Chỉ mục cho bảng `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`PublisherID`);

--
-- Chỉ mục cho bảng `purchaseorder`
--
ALTER TABLE `purchaseorder`
  ADD PRIMARY KEY (`OrderID`);

--
-- Chỉ mục cho bảng `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`ReviewID`);

--
-- Chỉ mục cho bảng `salesorder`
--
ALTER TABLE `salesorder`
  ADD PRIMARY KEY (`OrderID`);

--
-- Chỉ mục cho bảng `shippingaddress`
--
ALTER TABLE `shippingaddress`
  ADD PRIMARY KEY (`AddressID`);

--
-- Chỉ mục cho bảng `shoppingcart`
--
ALTER TABLE `shoppingcart`
  ADD PRIMARY KEY (`CartID`);

--
-- Chỉ mục cho bảng `shoppingcartdetail`
--
ALTER TABLE `shoppingcartdetail`
  ADD PRIMARY KEY (`CartItemID`);

--
-- Chỉ mục cho bảng `rental`
--
ALTER TABLE `rental`
  ADD PRIMARY KEY (`RentalID`);

--
-- Chỉ mục cho bảng `rentaldetail`
--
ALTER TABLE `rentaldetail`
  ADD PRIMARY KEY (`RentalDetailID`);

--
-- Chỉ mục cho bảng `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`SupplierID`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `admin`
--
ALTER TABLE `admin`
  MODIFY `AdminID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã tài khoản Admin', AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT cho bảng `book`
--
ALTER TABLE `book`
  MODIFY `BookID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã sách', AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `bookimage`
--
ALTER TABLE `bookimage`
  MODIFY `ImageID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã ảnh sách', AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT cho bảng `bookset`
--
ALTER TABLE `bookset`
  MODIFY `SetID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã bộ sách';

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã danh mục', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `coupon`
--
ALTER TABLE `coupon`
  MODIFY `CouponID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã mã giảm giá';

--
-- AUTO_INCREMENT cho bảng `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `genre`
--
ALTER TABLE `genre`
  MODIFY `GenreID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã thể loại', AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `publisher`
--
ALTER TABLE `publisher`
  MODIFY `PublisherID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã nhà xuất bản', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `purchaseorder`
--
ALTER TABLE `purchaseorder`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã hoá đơn nhập';

--
-- AUTO_INCREMENT cho bảng `review`
--
ALTER TABLE `review`
  MODIFY `ReviewID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã đánh giá';

--
-- AUTO_INCREMENT cho bảng `salesorder`
--
ALTER TABLE `salesorder`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã hoá đơn bán';

--
-- AUTO_INCREMENT cho bảng `shippingaddress`
--
ALTER TABLE `shippingaddress`
  MODIFY `AddressID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã địa chỉ';

--
-- AUTO_INCREMENT cho bảng `shoppingcart`
--
ALTER TABLE `shoppingcart`
  MODIFY `CartID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã giỏ hàng', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `shoppingcartdetail`
--
ALTER TABLE `shoppingcartdetail`
  MODIFY `CartItemID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã chi tiết giỏ hàng', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `rental`
--
ALTER TABLE `rental`
  MODIFY `RentalID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã chi tiết thuê', AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT cho bảng `rentaldetail`
--
ALTER TABLE `rentaldetail`
  MODIFY `RentalDetailID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã chi tiết thuê', AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT cho bảng `supplier`
--
ALTER TABLE `supplier`
  MODIFY `SupplierID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã nhà cung cấp', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Mã người dùng';

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
