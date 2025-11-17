-- CƠ BẢN 1
create database QuanLyThuVien;
use QuanLyThuVien;
create table TacGia (
	MaTacGia int primary key auto_increment,
    TenTacGia varchar(100) not null,
    QuocTich varchar(50)
);
create table DocGia (
	MaDocGia int primary key auto_increment,
    TenDocGia varchar(100) not null,
    DiaChi varchar(255),
    SoDienThoai varchar(15) unique
);

-- CƠ BẢN 2
-- Chèn dữ liệu vào bảng Tác Giả
insert into TacGia (TenTacGia, QuocTich)
values ('Nguyễn Nhật Ánh', 'Việt Nam'),
('J.K. Rowling', 'Anh'),
('Haruki Murakami', 'Nhật Bản'),
('Dale Carnegie', 'Mỹ');
-- Chèn dữ liệu vào bảng Độc Giả
insert into DocGia (TenDocGia, DiaChi, SoDienThoai)
values 
('Nguyễn Văn A', '123 Đường ABC, Hà Nội', '0901234567'),
('Trần Thị B', '456 Đường XYZ, TP.HCM', '0912345678'),
('Lê Văn C', '789 Đường LMN, Đà Nẵng', '0923456789'),
('Phạm Thị D', '101 Đường QRS, Hà Nội', '0934567890'),
('Hoàng Văn E', '202 Đường UVW, Cần Thơ', '0945678901');

-- CƠ BẢN 3
-- Lấy danh sách tất cả các tác giả có quốc tịch "Việt Nam"
select * from TacGia
where QuocTich like 'Việt Nam';
-- Lấy danh sách các độc giả có địa chỉ ở "Hà Nội"
select * from DocGia
where DiaChi like '%Hà Nội%';
-- Hiển thị TenDocGia và SoDienThoai của tất cả độc giả
select TenDocGia,SoDienThoai
from DocGia;

-- CƠ BẢN 4
-- Cập nhật địa chỉ cho độc giả Trần Thị B (MaDocGia = 2) thành "200 Đường XYZ, TP. Thủ Đức"
update DocGia
set DiaChi = '200 Đường XYZ, TP. Thủ Đức'
where MaDocGia = 2;
-- Xóa tác giả Haruki Murakami (MaTacGia = 3) ra khỏi bảng TacGia
delete from TacGia
where MaTacGia = 3;

-- KHÁ 5
create table Book (
	MaSach int primary key auto_increment,
    TenSach varchar(200) not null,
    NamXuatBan int,
    MaTacGia int,
    foreign key(MaTacGia) references TacGia(MaTacGia)
);
insert into Book (TenSach, NamXuatBan, MaTacGia)
values 
('Cho tôi xin một vé đi tuổi thơ', 2008, 1),
('Mắt biếc', 1990, 1),
('Harry Potter và Hòn đá Phù thủy', 1997, 2),
('Harry Potter và Phòng chứa Bí mật', 1998, 2),
('Đắc nhân tâm', 1936, 4);

-- Khá 6
-- Viết câu truy vấn để tìm các cuốn sách được xuất bản lớn hơn hoặc bằng năm 1990 VÀ nhỏ hơn hoặc bằng năm 2000
select * from book
where NamXuatBan >=1990 and NamXuatBan <=2000;
-- Sử dụng toán tử OR, viết câu truy vấn để tìm các cuốn sách có tên chính xác là 'Harry Potter và Hòn đá Phù thủy' HOẶC 'Harry Potter và Phòng chứa Bí mật'
select * from book
where TenSach = 'Harry Potter và Hòn đá Phù Thuỷ' or TenSach = 'Harry Potter và Phòng chứa Bí mật';
-- Viết câu truy vấn để tìm các cuốn sách của tác giả có MaTacGia = 1 VÀ được xuất bản sau năm 2000
select * from book
where MaTacGia=1 and NamXuatBan>2000;

-- KHÁ 7
-- Hiển thị danh sách các sách trong bảng Sach, sắp xếp theo NamXuatBan từ mới nhất đến cũ nhất (DESC).
select * from boook
order by NamXuatBan desc;
-- Hiển thị danh sách độc giả, sắp xếp theo TenDocGia theo thứ tự alphabet (A-Z) (ASC)
select * from DocGia
order by TenDocGia asc;
-- Tạo bảng PhieuMuon
create table PhieuMuon (
    MaPhieuMuon int primary key auto_increment,
    NgayMuon date,
    NgayTra date,
    MaDocGia int,
    MaSach int,
    foreign key (MaDocGia) references DocGia(MaDocGia),
    foreign key (MaSach) references Book(MaSach)
);

-- GIỎI 8
-- Sử dụng ALTER TABLE để thêm một cột TrangThai (VARCHAR(50)) vào bảng Sach
alter table Book
add column TrangThai varchar(50);
-- Cập nhật cột TrangThai thành "Còn hàng" cho tất cả các sách được xuất bản trước năm 2000
set sql_safe_updates = 0;
update Book
set TrangThai='còn hàng'
where NamXuatBan<2000;
-- Cập nhật cột TrangThai thành "Mới nhập" cho tất cả các sách được xuất bản từ năm 2000 trở về sau
update Book
set TrangThai='mới nhập'
where NamXuatBan>2000;

-- GIỎI 9
-- Chèn ít nhất 5 dòng dữ liệu vào bảng PhieuMuon
insert into PhieuMuon (MaDocGia, MaSach, NgayMuon, NgayTra)
values 
(1, 1, '2024-01-10', '2024-01-25'),
(2, 3, '2024-02-15', NULL),
(1, 2, '2024-03-01', '2024-03-15'),
(3, 4, '2024-03-05', NULL),
(5, 5, '2024-04-20', '2024-05-01');
-- Viết câu truy vấn để tìm tất cả các phiếu mượn của độc giả có MaDocGia là 1
select * from phieumuon
where MaDocGia = 1;
-- Viết câu truy vấn để liệt kê tất cả các phiếu mượn sách chưa được trả (NgayTra có giá trị là NULL)
select * from PhieuMuon
where NgayTra is null;

-- XUẤT SẮC 10
-- Kiểm tra
select * from PhieuMuon
where MaDocGia=1 and NgayTra is null;
-- Xoá lịch sử mượn
delete from PhieuMuon
where MaDocGia=1;
-- Xoá độc giả
delete from DocGia
where MaDocGia=1;