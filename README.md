# E-Commerce Logistics Tracker (SQL Project)

## Objectives

* Track shipment details and delivery status
* Identify delayed shipments
* Analyze delivery partner performance
* Find high-demand delivery zones

---

## Technologies Used

* MySQL
* SQL (DDL, DML, Joins, Aggregations)

---

## Database Schema

### 1. Partners

Stores delivery partner details

* PartnerID (Primary Key)
* PartnerName
* Contact

### 2. Shipments

Stores shipment information

* ShipmentID (Primary Key)
* PartnerID (Foreign Key)
* DestinationCity
* ShipDate
* PromiseDate
* ActualDeliveryDate
* Status

### 3. DeliveryLogs

Tracks shipment updates

* LogID (Primary Key)
* ShipmentID (Foreign Key)
* UpdateStatus
* UpdateTime

---

## Key Features & Queries

### Delayed Shipments

Identifies shipments delivered after the promised date.

### Performance Analysis

Compares delivery partners based on:

* Successful deliveries
* Returned shipments

### Zone Filter

Finds the most active destination city in the last 30 days.

### Partner Scorecard

Ranks delivery partners based on the number of delays.

---

## How to Run

1. Open MySQL Workbench
2. Open the SQL file
3. Execute the script
4. View results in the result grid

---

## Output

The system generates:

* Shipment tracking data
* Delay reports
* Partner performance metrics
* Final scorecard ranking

