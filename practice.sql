USE PracticeDB;
GO
DROP TABlE IF EXISTS PriceHistory;
DROP TABlE IF EXISTS BillDetail;
DROP TABlE IF EXISTS BillSource;
DROP TABlE IF EXISTS HangHoa;
DROP TABlE IF EXISTS NhanVien;
--Drop table tránh bị lặp create từ lần chạy trc
GO
CREATE TABLE NhanVien (
    Idnv INT PRIMARY KEY,
    Name NVARCHAR(100),
);
GO
CREATE TABLE HangHoa (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
);
GO
CREATE TABLE PriceHistory (
    ID INT PRIMARY KEY,
    HangHoaID INT,
    ValidFrom DATE NOT NULL,
    ValidTo DATE,
    ItemPrice INT,
    CONSTRAINT HangHoaID
        FOREIGN KEY (HangHoaID)
        REFERENCES HangHoa(ID)
);
GO
CREATE TABLE BillSource (
    BillID INT PRIMARY KEY,
    IdSeller INT,
    date DATE,
    CONSTRAINT seller 
        FOREIGN KEY (IdSeller) 
        REFERENCES NhanVien(Idnv)
);
GO
CREATE TABLE BillDetail(
    BillID INT,
    ItemID INT,
    ItemCount INT,
    PRIMARY KEY (BillID,ItemID),
    CONSTRAINT bill
        FOREIGN KEY (BillID)
        REFERENCES BillSource(BillID),
    CONSTRAINT item
        FOREIGN KEY (ItemID)
        REFERENCES HangHoa(ID)
);
GO
--Tạo table

INSERT INTO NhanVien (Idnv, Name)
VALUES
(1, 'Minh'),
(2, 'Vũ'),
(3, 'Mai');
GO

INSERT INTO HangHoa (ID, Name)
VALUES
(1, 'cake'),
(2, 'ice-cream'),
(3, 'Ca-cao'),
(4, 'candy');
GO
INSERT INTO PriceHistory (ID, HangHoaID,ItemPrice,ValidFrom,ValidTo)
VALUES
(1, 1,150,'2025-01-01',NULL),
(2, 2,15,'2025-01-01',NULL),
(3, 3,30,'2025-01-01','2025-01-04'),
(4, 4,10,'2025-01-01',NULL),
(5,3, 35,'2025-01-05', NULL);
GO

INSERT INTO BillSource (BillID, IdSeller, date)
VALUES
(1001, 1, '2025-01-01'),
(1002, 1, '2025-01-02'),
(1003, 2, '2025-01-03'),
(1004, 3, '2025-01-04'),
(1005, 2, '2025-01-05'),
(1006, 2, '2025-01-05'),
(1007, 2, '2025-01-05'),
(1008, 2, '2025-01-05'),
(1009, 2, '2025-01-06');
GO
INSERT INTO BillDetail (BillID, ItemID, ItemCount)
VALUES
(1001, 1, 2),  
(1001, 2, 5),  
(1002, 1, 3),  
(1002, 3, 2),   
(1003, 2, 10), 
(1004, 1, 1), 
(1004, 2, 2), 
(1004, 3, 4),  
(1005, 3, 6),   
(1006, 4, 10),
(1007, 1, 2), 
(1008, 2, 5), 
(1009, 1, 3);
GO
-- add các giá trị--
SELECT [date],SUM(PriceHistory.ItemPrice*ItemCount) AS BillIncomeByDate
FROM BillDetail
JOIN HangHoa ON HangHoa.ID=BillDetail.ItemID
JOIN BillSource ON BillSource.BillID=BillDetail.BillID
JOIN PriceHistory ON HangHoa.ID= PriceHistory.HangHoaID
GROUP BY [date]

SELECT ItemID,SUM(ItemCount) AS SellCount,SUM(ItemPrice*ItemCount) AS BillIncomeByItem
FROM BillDetail
JOIN HangHoa ON HangHoa.ID=BillDetail.ItemID
JOIN BillSource ON BillSource.BillID=BillDetail.BillID
JOIN PriceHistory ON HangHoa.ID= PriceHistory.HangHoaID
GROUP BY ItemID

SELECT IdSeller,SUM(ItemPrice*ItemCount) AS BillIncomeByPerson
FROM BillDetail
JOIN HangHoa ON HangHoa.ID=BillDetail.ItemID
JOIN BillSource ON BillSource.BillID=BillDetail.BillID
JOIN PriceHistory ON HangHoa.ID= PriceHistory.HangHoaID
GROUP BY IdSeller

SELECT TOP 1
    NhanVien.Name,SUM(ItemPrice*ItemCount) AS top1employee
FROM BillDetail
JOIN HangHoa ON HangHoa.ID=BillDetail.ItemID
JOIN BillSource ON BillSource.BillID=BillDetail.BillID
JOIN NhanVien ON NhanVien.Idnv=BillSource.IdSeller
JOIN PriceHistory ON HangHoa.ID= PriceHistory.HangHoaID
GROUP BY NhanVien.Name
ORDER BY top1employee DESC
--chạy qua thử












