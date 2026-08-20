# PracticeDB - Sales Management Database

## Giới thiệu

Database `PracticeDB` được thiết kế để quản lý dữ liệu bán hàng cơ bản. Hệ thống bao gồm các chức năng chính như quản lý nhân viên, hàng hoá, lịch sử giá sản phẩm, hoá đơn và chi tiết sản phẩm trong từng hoá đơn.

Database này phù hợp cho việc thực hành các thao tác SQL như:

- Tạo bảng bằng `CREATE TABLE`
- Xoá bảng cũ bằng `DROP TABLE IF EXISTS`
- Thiết lập khoá chính và khoá ngoại
- Thêm dữ liệu bằng `INSERT INTO`
- Truy vấn doanh thu theo ngày
- Truy vấn doanh thu theo sản phẩm
- Truy vấn doanh thu theo nhân viên
- Tìm nhân viên có doanh thu cao nhất

---

## Cấu trúc bảng tổng quan

| Bảng | Chức năng |
|---|---|
| `NhanVien` | Lưu thông tin nhân viên bán hàng. |
| `HangHoa` | Lưu danh sách sản phẩm/hàng hoá được bán. |
| `PriceHistory` | Lưu lịch sử giá của từng sản phẩm theo thời gian. |
| `BillSource` | Lưu thông tin chính của hoá đơn. |
| `BillDetail` | Lưu chi tiết sản phẩm trong từng hoá đơn. |

---

## Chi tiết thuộc tính các bảng

### Bảng `NhanVien`

Bảng `NhanVien` dùng để lưu thông tin cơ bản của nhân viên bán hàng trong hệ thống.

| Thuộc tính | Kiểu dữ liệu | Ràng buộc | Mô tả |
|---|---|---|---|
| `Idnv` | `INT` | Primary Key | Mã định danh duy nhất của nhân viên. |
| `Name` | `NVARCHAR(100)` | Không có ràng buộc `NOT NULL` trong code hiện tại | Tên của nhân viên. |

#### Giải thích

Mỗi nhân viên có một mã riêng là `Idnv`. Mã này được dùng để liên kết với bảng `BillSource`, giúp xác định nhân viên nào đã lập hoá đơn.

---

### Bảng `HangHoa`

Bảng `HangHoa` dùng để lưu danh sách các sản phẩm/hàng hoá được bán trong hệ thống.

| Thuộc tính | Kiểu dữ liệu | Ràng buộc | Mô tả |
|---|---|---|---|
| `ID` | `INT` | 
