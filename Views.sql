Select * from TotalBookings
Select * from RevenuebyTripType
Select * from CancellationRate
Select * from PeakBookingPeriods
Select * from AverageBookingRate

Select * from PreferredTripTypes
Select * from AverageSpending

Select * from AverageRating
Select * from RevenuePerOperator
Select * from ResponseTime

Select * from ProviderRating
Select * from TopProviders
Select * from Punctuality

Alter View TotalBookings As 
Select Status, Count(*) as TotalBookings from Booking Group by Status

Alter View RevenuebyTripType AS
Select c.Name as TripType, Sum(t.Cost) AS TotalRevenue from Category c JOIN Trip t ON c.CategoryID = t.CategoryID Group by c.CategoryID, c.Name

Alter View CancellationRate AS
Select (CAST(Count(*) AS Float)/(Select Count(*) from Booking))*100 AS CancelledBookings from Booking where Status != 'Completed'

Create View PeakBookingPeriods AS
Select DateName(Month, BookingDate) AS Month, Count(*) AS Bookings from Booking Group by DateName(Month, BookingDate)

Alter View AverageBookingRate AS
Select Avg(Amount) AS AverageBookingRate from Booking

Alter View PreferredTripTypes AS
Select c.Name AS TripType, Count(*) AS Bookings from Booking b JOIN Trip t ON t.TripID = b.TripID JOIN Category c ON c.CategoryID = t.CategoryID Group by c.CategoryID, c.Name

Alter View AverageSpending AS
Select u.Name AS TravellerName, Avg(b.Amount) AS AverageSpending from Booking b JOIN Traveller t ON t.TravellerID = b.TravellerID JOIN Users u ON u.UserID = t.TravellerID Group by t.TravellerID, u.Name

Alter View AverageRating AS 
Select Avg(r.rating) AS AverageRating from Trip t JOIN Review r ON r.TripID = t.TripID

Alter View RevenuePerOperator AS
Select u.Name AS TourOperatorName, ISNULL(Sum(b.Amount), 0) AS RevenueGenerated from TourOperator tp LEFT JOIN Trip t ON t.TourOperatorID = tp.TID LEFT JOIN Booking b ON b.TripID = t.TripID JOIN Users u ON u.UserID = tp.TID Group by tp.TID, u.Name

Create View ResponseTime As
SELECT AVG(DATEDIFF(MINUTE, s.AssignedAt, b.BookedAt)) AS AvgMinutesDifference
FROM Booking b
JOIN ServiceAssignment s ON s.BookingID = b.BookingID;

Alter View ProviderRating AS
Select u.Name AS ServiceProvider, Avg(r.Rating) AS AverageFeedbackScore from Review r JOIN Trip t on t.TripID = r.TripID JOIN Booking b ON b.TripID = t.TripID JOIN ServiceAssignment s ON s.BookingID = b.BookingID JOIN Users u ON u.UserID = s.ServiceProviderID Group by s.ServiceProviderID, u.Name

Alter View TopProviders AS
Select u.Name AS ServiceProvider, Count(*) AS ServicesProvidedToTrips from Review r Left JOIN Trip t on t.TripID = r.TripID Left JOIN Booking b ON b.TripID = t.TripID Left JOIN ServiceAssignment s ON s.BookingID = b.BookingID JOIN Users u ON u.UserID = s.ServiceProviderID Group by s.ServiceProviderID, u.Name

Alter View Punctuality AS
SELECT 
    u.Name AS ServiceProvider,
    ((AVG(r.Rating) - 1) / 4.0) * 100 AS PunctualityScore
FROM 
    Review r
JOIN Trip t ON t.TripID = r.TripID
JOIN Booking b ON b.TripID = t.TripID
JOIN ServiceAssignment s ON s.BookingID = b.BookingID
JOIN Users u ON u.UserID = s.ServiceProviderID
GROUP BY 
    s.ServiceProviderID, u.Name;
