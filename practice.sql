USE PracticeDB;
GO
--DROP TABlE IF EXISTS PriceHistory;
DROP TABlE IF EXISTS Bill_Detail;
DROP TABlE IF EXISTS Bill_Source;
DROP TABlE IF EXISTS Product;
DROP TABlE IF EXISTS Employee;
--Drop table tránh bị lặp create từ lần chạy trc
GO
CREATE TABLE Employee (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100),
);
GO
CREATE TABLE Product (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100),
    ItemPrice INT,
);
GO
/*CREATE TABLE PriceHistory (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    HangHoaID INT,
    ValidFrom DATE NOT NULL,
    ValidTo DATE,
    ItemPrice INT,
    CONSTRAINT HangHoaID
        FOREIGN KEY (HangHoaID)
        REFERENCES HangHoa(ID)
);
GO*/
CREATE TABLE Bill_Source (
    BillID INT IDENTITY(1,1) PRIMARY KEY,
    IdSeller INT,
    date DATE,
    CONSTRAINT seller 
        FOREIGN KEY (IdSeller) 
        REFERENCES NhanVien(Idnv)
);
GO
CREATE TABLE Bill_Detail(
    BillID INT,
    ItemID INT,
    ItemCount INT,
    Itemprice INT,
    PRIMARY KEY (BillID,ItemID),
    
    CONSTRAINT bill
        FOREIGN KEY (BillID)
        REFERENCES Bill_Source(BillID),
    CONSTRAINT item
        FOREIGN KEY (ItemID)
        REFERENCES HangHoa(ID)
);
GO
--Tạo table

INSERT INTO Employee ( Name)
VALUES
('Minh'),
('Vũ'),
('Mai');
GO

INSERT INTO Product ( Name,Itemprice)
VALUES
('cake',70),
('ice-cream',15),
('Ca-cao',10),
('candy',5);
GO
/*INSERT INTO PriceHistory (ID, HangHoaID,ItemPrice,ValidFrom,ValidTo)
VALUES
(1, 1,150,'2025-01-01',NULL),
(2, 2,15,'2025-01-01',NULL),
(3, 3,30,'2025-01-01','2025-01-04'),
(4, 4,10,'2025-01-01',NULL),
(5,3, 35,'2025-01-05', NULL);
GO*/

INSERT INTO Bill_Source ( IdSeller, date)
VALUES
( 1, '2025-01-01'),
( 1, '2025-01-02'),
( 2, '2025-01-03'),
( 3, '2025-01-04'),
( 2, '2025-01-05'),
( 2, '2025-01-05'),
( 2, '2025-01-05'),
( 2, '2025-01-05'),
( 2, '2025-01-06');
GO
INSERT INTO Product (Name, Itemprice)
VALUES
('cake', 70),
('ice-cream', 15),
('Ca-cao', 10),
('candy', 5);
GO

INSERT INTO Bill_Detail (BillID, ItemID, ItemCount, Itemprice)
VALUES
(1, 1, 2, 70),  
(1, 2, 5, 15),  
(2, 1, 3, 70),  
(2, 3, 2, 10),   
(3, 2, 10, 15), 
(4, 1, 1, 70), 
(4, 2, 2, 15), 
(4, 3, 4, 10),  
(5, 3, 6, 10),   
(6, 4, 10, 5),
(7, 1, 2, 70), 
(8, 2, 5, 15), 
(9, 1, 3, 70);
GO
-- add các giá trị--
--SELECT * FROM PriceHistory;
SELECT * FROM Employee;
SELECT * FROM Product;
SELECT * FROM Bill_Source;
SELECT * FROM Bill_Detail;
-- chạy qua thử
-- note feedback: thêm item price BillDetails (reference: sql northwind database)
-- sửa lại đặt tên thuần vn hoặc eng
-- 












