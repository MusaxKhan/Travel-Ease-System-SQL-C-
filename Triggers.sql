-- Create AuditLog table
CREATE TABLE AuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    TableName NVARCHAR(128),
    Action NVARCHAR(10),
    ActionTime DATETIME DEFAULT GETDATE(),
    RowID NVARCHAR(100)
);
GO

-- Users
CREATE TRIGGER trg_Users_Insert ON Users AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Users', 'INSERT', CAST(UserID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Users_Update ON Users AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Users', 'UPDATE', CAST(UserID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Users_Delete ON Users AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Users', 'DELETE', CAST(UserID AS NVARCHAR) FROM deleted
END;
GO


-- ServiceProvider
CREATE TRIGGER trg_ServiceProvider_Insert ON ServiceProvider AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'ServiceProvider', 'INSERT', CAST(SpID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_ServiceProvider_Update ON ServiceProvider AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'ServiceProvider', 'UPDATE', CAST(SpID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_ServiceProvider_Delete ON ServiceProvider AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'ServiceProvider', 'DELETE', CAST(SpID AS NVARCHAR) FROM deleted
END;
GO

-- Admin
CREATE TRIGGER trg_Admin_Insert ON Admin AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Admin', 'INSERT', CAST(AdminID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Admin_Update ON Admin AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Admin', 'UPDATE', CAST(AdminID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Admin_Delete ON Admin AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Admin', 'DELETE', CAST(AdminID AS NVARCHAR) FROM deleted
END;
GO

-- Traveller
CREATE TRIGGER trg_Traveller_Insert ON Traveller AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Traveller', 'INSERT', CAST(TravellerID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Traveller_Update ON Traveller AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Traveller', 'UPDATE', CAST(TravellerID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Traveller_Delete ON Traveller AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Traveller', 'DELETE', CAST(TravellerID AS NVARCHAR) FROM deleted
END;
GO

-- TourOperator
CREATE TRIGGER trg_TourOperator_Insert ON TourOperator AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'TourOperator', 'INSERT', CAST(TID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_TourOperator_Update ON TourOperator AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'TourOperator', 'UPDATE', CAST(TID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_TourOperator_Delete ON TourOperator AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'TourOperator', 'DELETE', CAST(TID AS NVARCHAR) FROM deleted
END;
GO

-- Category
CREATE TRIGGER trg_Category_Insert ON Category AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Category', 'INSERT', CAST(CategoryID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Category_Update ON Category AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Category', 'UPDATE', CAST(CategoryID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Category_Delete ON Category AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Category', 'DELETE', CAST(CategoryID AS NVARCHAR) FROM deleted
END;
GO

-- Trip
CREATE TRIGGER trg_Trip_Insert ON Trip AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Trip', 'INSERT', CAST(TripID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Trip_Update ON Trip AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Trip', 'UPDATE', CAST(TripID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Trip_Delete ON Trip AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Trip', 'DELETE', CAST(TripID AS NVARCHAR) FROM deleted
END;
GO

-- Destination
CREATE TRIGGER trg_Destination_Insert ON Destination AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Destination', 'INSERT', CAST(DestinationID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Destination_Update ON Destination AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Destination', 'UPDATE', CAST(DestinationID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Destination_Delete ON Destination AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Destination', 'DELETE', CAST(DestinationID AS NVARCHAR) FROM deleted
END;
GO

-- TripDestination
CREATE TRIGGER trg_TripDestination_Insert ON TripDestination AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'TripDestination', 'INSERT', CAST(TripID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_TripDestination_Update ON TripDestination AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'TripDestination', 'UPDATE', CAST(TripID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_TripDestination_Delete ON TripDestination AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'TripDestination', 'DELETE', CAST(TripID AS NVARCHAR) FROM deleted
END;
GO

-- Review
CREATE TRIGGER trg_Review_Insert ON Review AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Review', 'INSERT', CAST(ReviewID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Review_Update ON Review AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Review', 'UPDATE', CAST(ReviewID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Review_Delete ON Review AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Review', 'DELETE', CAST(ReviewID AS NVARCHAR) FROM deleted
END;
GO

-- AdminReviewFilter
CREATE TRIGGER trg_AdminReviewFilter_Insert ON AdminReviewFilter AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'AdminReviewFilter', 'INSERT', CAST(AdminID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_AdminReviewFilter_Update ON AdminReviewFilter AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'AdminReviewFilter', 'UPDATE', CAST(AdminID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_AdminReviewFilter_Delete ON AdminReviewFilter AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'AdminReviewFilter', 'DELETE', CAST(AdminID AS NVARCHAR) FROM deleted
END;
GO

-- AdminCategoryOversee
CREATE TRIGGER trg_AdminCategoryOversee_Insert ON AdminCategoryOversee AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'AdminCategoryOversee', 'INSERT', CAST(AdminID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_AdminCategoryOversee_Update ON AdminCategoryOversee AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'AdminCategoryOversee', 'UPDATE', CAST(AdminID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_AdminCategoryOversee_Delete ON AdminCategoryOversee AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'AdminCategoryOversee', 'DELETE', CAST(AdminID AS NVARCHAR) FROM deleted
END;
GO

-- Booking
CREATE TRIGGER trg_Booking_Insert ON Booking AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Booking', 'INSERT', CAST(BookingID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Booking_Update ON Booking AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Booking', 'UPDATE', CAST(BookingID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Booking_Delete ON Booking AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Booking', 'DELETE', CAST(BookingID AS NVARCHAR) FROM deleted
END;
GO

-- ServiceAssignment
CREATE TRIGGER trg_ServiceAssignment_Insert ON ServiceAssignment AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'ServiceAssignment', 'INSERT', CAST(ServiceProviderID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_ServiceAssignment_Update ON ServiceAssignment AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'ServiceAssignment', 'UPDATE', CAST(ServiceProviderID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_ServiceAssignment_Delete ON ServiceAssignment AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'ServiceAssignment', 'DELETE', CAST(ServiceProviderID AS NVARCHAR) FROM deleted
END;
GO

-- DigitalPass
Select * from DigitalPass
CREATE TRIGGER trg_DigitalPass_Insert ON DigitalPass AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'DigitalPass', 'INSERT', CAST(PassID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_DigitalPass_Update ON DigitalPass AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'DigitalPass', 'UPDATE', CAST(PassID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_DigitalPass_Delete ON DigitalPass AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'DigitalPass', 'DELETE', CAST(PassID AS NVARCHAR) FROM deleted
END;
GO

-- AbandonedBooking
CREATE TRIGGER trg_AbandonedBooking_Insert ON AbandonedBooking AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'AbandonedBooking', 'INSERT', CAST(BookingID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_AbandonedBooking_Update ON AbandonedBooking AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'AbandonedBooking', 'UPDATE', CAST(BookingID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_AbandonedBooking_Delete ON AbandonedBooking AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'AbandonedBooking', 'DELETE', CAST(BookingID AS NVARCHAR) FROM deleted
END;
GO

-- CompletedBooking
CREATE TRIGGER trg_CompletedBooking_Insert ON CompletedBooking AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'CompletedBooking', 'INSERT', CAST(BookingID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_CompletedBooking_Update ON CompletedBooking AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'CompletedBooking', 'UPDATE', CAST(BookingID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_CompletedBooking_Delete ON CompletedBooking AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'CompletedBooking', 'DELETE', CAST(BookingID AS NVARCHAR) FROM deleted
END;
GO

-- Refund
CREATE TRIGGER trg_Refund_Insert ON Refund AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Refund', 'INSERT', CAST(RefundID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Refund_Update ON Refund AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Refund', 'UPDATE', CAST(RefundID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Refund_Delete ON Refund AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Refund', 'DELETE', CAST(RefundID AS NVARCHAR) FROM deleted
END;
GO

-- Wishlist
CREATE TRIGGER trg_Wishlist_Insert ON Wishlist AFTER INSERT AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Wishlist', 'INSERT', CAST(WishlistID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Wishlist_Update ON Wishlist AFTER UPDATE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Wishlist', 'UPDATE', CAST(WishlistID AS NVARCHAR) FROM inserted
END;
GO
CREATE TRIGGER trg_Wishlist_Delete ON Wishlist AFTER DELETE AS
BEGIN
    INSERT INTO AuditLog (TableName, Action, RowID)
    SELECT 'Wishlist', 'DELETE', CAST(WishlistID AS NVARCHAR) FROM deleted
END;
GO

Update Booking Set TripID = 3 where BookingID = 108