-- =====================================
-- E-COMMERCE LOGISTICS TRACKER PROJECT
-- =====================================

-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS ecommerce_logistics;
USE ecommerce_logistics;

-- =====================================
-- 2. TABLES (Schema Design)
-- =====================================

-- Partners Table
CREATE TABLE IF NOT EXISTS Partners (
    PartnerID INT PRIMARY KEY AUTO_INCREMENT,
    PartnerName VARCHAR(100),
    Contact VARCHAR(50)
);

-- Shipments Table
CREATE TABLE IF NOT EXISTS Shipments (
    ShipmentID INT PRIMARY KEY AUTO_INCREMENT,
    PartnerID INT,
    DestinationCity VARCHAR(100),
    ShipDate DATE,
    PromiseDate DATE,
    ActualDeliveryDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (PartnerID) REFERENCES Partners(PartnerID)
);

-- DeliveryLogs Table
CREATE TABLE IF NOT EXISTS DeliveryLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    ShipmentID INT,
    UpdateStatus VARCHAR(100),
    UpdateTime DATETIME,
    FOREIGN KEY (ShipmentID) REFERENCES Shipments(ShipmentID)
);

-- =====================================
-- 3. INSERT DATA
-- =====================================

-- Partners Data
INSERT INTO Partners (PartnerName, Contact) VALUES
('DHL', '9876543210'),
('FedEx', '9123456780'),
('BlueDart', '9988776655');

-- Shipments Data
INSERT INTO Shipments (PartnerID, DestinationCity, ShipDate, PromiseDate, ActualDeliveryDate, Status) VALUES
(1, 'Chennai', '2024-04-01', '2024-04-05', '2024-04-06', 'Delivered'),
(2, 'Madurai', '2024-04-02', '2024-04-06', '2024-04-05', 'Delivered'),
(3, 'Coimbatore', '2024-04-03', '2024-04-07', NULL, 'In Transit'),
(1, 'Chennai', '2024-04-04', '2024-04-08', '2024-04-10', 'Delivered'),
(2, 'Trichy', '2024-04-05', '2024-04-09', '2024-04-12', 'Returned');

-- Delivery Logs (optional but good)
INSERT INTO DeliveryLogs (ShipmentID, UpdateStatus, UpdateTime) VALUES
(1, 'Shipped', NOW()),
(1, 'Delivered', NOW()),
(2, 'Delivered', NOW());

-- 1. Delayed Shipments
SELECT *
FROM Shipments
WHERE ActualDeliveryDate > PromiseDate;

-- 2. Performance Ranking (Successful vs Returned)
SELECT 
    p.PartnerName,
    COUNT(CASE WHEN s.Status = 'Delivered' THEN 1 END) AS Successful,
    COUNT(CASE WHEN s.Status = 'Returned' THEN 1 END) AS Returned
FROM Shipments s
JOIN Partners p ON s.PartnerID = p.PartnerID
GROUP BY p.PartnerName;

-- 3. Zone Filter (Most Popular City - Last 30 Days)
SELECT DestinationCity, COUNT(*) AS TotalOrders
FROM Shipments
WHERE ShipDate >= CURDATE() - INTERVAL 30 DAY
GROUP BY DestinationCity
ORDER BY TotalOrders DESC
LIMIT 1;

-- 4. FINAL PARTNER SCORECARD (Deliverable)
SELECT 
    p.PartnerName,
    COUNT(*) AS TotalShipments,
    SUM(CASE WHEN s.ActualDeliveryDate > s.PromiseDate THEN 1 ELSE 0 END) AS Delays
FROM Shipments s
JOIN Partners p ON s.PartnerID = p.PartnerID
GROUP BY p.PartnerName
ORDER BY Delays ASC;

