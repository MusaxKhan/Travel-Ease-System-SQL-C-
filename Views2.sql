CREATE TABLE DestinationPopularityReport (
    ReportID INT PRIMARY KEY IDENTITY(1,1),
    City VARCHAR(100),
    Country VARCHAR(100),
    TotalBookings INT,
    AverageRating DECIMAL(3, 2),
    MonthWithMostBookings VARCHAR(20),
    RecentYearBookings INT
);

select * from DestinationPopularityReport

INSERT INTO DestinationPopularityReport (City, Country, TotalBookings, AverageRating, MonthWithMostBookings, RecentYearBookings)
SELECT 
    D.City,
    D.Country,
    
    -- Total Bookings
    COUNT(B.BookingID) AS TotalBookings,

    -- Average Rating
    ISNULL(AVG(R.Rating), 0) AS AverageRating,

    -- Most Frequent Booking Month (as text)
    (
        SELECT TOP 1 DATENAME(MONTH, B2.BookingDate)
        FROM Booking B2
        JOIN Trip T2 ON B2.TripID = T2.TripID
        JOIN TripDestination TD2 ON T2.TripID = TD2.TripID
        WHERE TD2.DestinationID = TD.DestinationID
        GROUP BY DATENAME(MONTH, B2.BookingDate)
        ORDER BY COUNT(*) DESC
    ) AS MonthWithMostBookings,

    -- Recent Year Bookings
    SUM(CASE WHEN B.BookingDate >= DATEADD(YEAR, -1, GETDATE()) THEN 1 ELSE 0 END) AS RecentYearBookings

FROM 
    Destination D
JOIN 
    TripDestination TD ON D.DestinationID = TD.DestinationID
JOIN 
    Trip T ON TD.TripID = T.TripID
LEFT JOIN 
    Booking B ON T.TripID = B.TripID
LEFT JOIN 
    Review R ON T.TripID = R.TripID

GROUP BY 
    D.City, D.Country, TD.DestinationID;


	CREATE TABLE AbandonedBookingAnalysisReport (
    ReportID INT PRIMARY KEY IDENTITY(1,1),
    ReportDate DATE NOT NULL DEFAULT GETDATE(),
    TotalBookings INT NOT NULL,
    AbandonedBookings INT NOT NULL,
    CompletedBookings INT NOT NULL,
    AbandonmentRate DECIMAL(5,2) NOT NULL,         -- % of total
    RecoveryRate DECIMAL(5,2) NOT NULL,            -- % recovered
    PotentialRevenueLoss DECIMAL(10,2) NOT NULL,   -- Estimated lost revenue
    MostCommonReason VARCHAR(100) NOT NULL         -- From AbandonedBooking
);

select * from AbandonedBookingAnalysisReport
INSERT INTO AbandonedBookingAnalysisReport (
    ReportDate, 
    TotalBookings, 
    CompletedBookings,
    AbandonedBookings, 
    AbandonmentRate, 
    MostCommonReason, 
    RecoveryRate, 
    PotentialRevenueLoss
)
SELECT 
    GETDATE() AS ReportDate,
    (SELECT COUNT(*) FROM Booking) AS TotalBookings,
    (SELECT COUNT(*) FROM Booking WHERE Status = 'Completed') AS CompletedBookings,
    (SELECT COUNT(*) FROM Booking WHERE Status = 'Abandoned') AS AbandonedBookings,
    CAST(
        100.0 * (SELECT COUNT(*) FROM Booking WHERE Status = 'Abandoned') / 
        NULLIF((SELECT COUNT(*) FROM Booking), 0)
        AS DECIMAL(5,2)
    ) AS AbandonmentRate,
    (
        SELECT TOP 1 CAST(Reason AS VARCHAR(MAX))
        FROM AbandonedBooking 
        GROUP BY CAST(Reason AS VARCHAR(MAX)) 
        ORDER BY COUNT(*) DESC
    ) AS MostCommonReason,
    CAST(
        100.0 * (
            SELECT COUNT(*) 
            FROM CompletedBooking 
            WHERE BookingID IN (SELECT BookingID FROM AbandonedBooking)
        ) / NULLIF(
            (SELECT COUNT(*) FROM AbandonedBooking), 0
        ) AS DECIMAL(5,2)
    ) AS RecoveryRate,
    (
        SELECT SUM(Amount) 
        FROM Booking 
        WHERE Status = 'Abandoned'
    ) AS PotentialRevenueLoss;

	CREATE TABLE PlatformGrowthReport (
    ReportID INT PRIMARY KEY IDENTITY(1,1),
    ReportMonth DATE NOT NULL,
    NewTravellers INT DEFAULT 0,
    NewTourOperators INT DEFAULT 0,
    NewServiceProviders INT DEFAULT 0,
    ActiveTravellers INT DEFAULT 0,
    ActiveTourOperators INT DEFAULT 0,
    NewPartners INT DEFAULT 0, 
    NewDestinations INT DEFAULT 0
);
Delete from PlatformGrowthReport

Select * from PlatformGrowthReport

DECLARE @CurrentMonth DATE = DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1);
DECLARE @CutoffMonth DATE = DATEADD(MONTH, -4, @CurrentMonth);  

IF NOT EXISTS (SELECT 1 FROM PlatformGrowthReport WHERE ReportMonth = @CurrentMonth)
BEGIN
    INSERT INTO PlatformGrowthReport (
        ReportMonth,
        NewTravellers,
        NewTourOperators,
        NewServiceProviders,
        ActiveTravellers,
        ActiveTourOperators,
        NewPartners,
        NewDestinations
    )
    SELECT
        @CurrentMonth,

        COUNT(DISTINCT CASE WHEN t.TravellerID IS NOT NULL AND u.RegDate >= @CutoffMonth THEN t.TravellerID END),

        COUNT(DISTINCT CASE WHEN o.TID IS NOT NULL AND u.RegDate >= @CutoffMonth THEN o.TID END),

        COUNT(DISTINCT CASE WHEN s.SpID IS NOT NULL AND u.RegDate >= @CutoffMonth THEN s.SpID END),

        (SELECT COUNT(DISTINCT TravellerID) FROM Booking
         WHERE BookingDate >= @CutoffMonth),

        (SELECT COUNT(DISTINCT TourOperatorID) FROM ServiceAssignment sa
         JOIN Booking b ON sa.BookingID = b.BookingID
         WHERE b.BookingDate >= @CutoffMonth),

        (
            (SELECT COUNT(*) FROM ServiceProvider s
             JOIN Users u ON s.SpID = u.UserID
             WHERE u.RegDate >= @CutoffMonth)
            +
            (SELECT COUNT(*) FROM TourOperator o
             JOIN Users u ON o.TID = u.UserID
             WHERE u.RegDate >= @CutoffMonth)
        ),

        (SELECT COUNT(DISTINCT DestinationID) FROM TripDestination td
         JOIN Trip t ON td.TripID = t.TripID
         WHERE t.StartDate >= @CutoffMonth)
    FROM Users u
    LEFT JOIN Traveller t ON u.UserID = t.TravellerID
    LEFT JOIN TourOperator o ON u.UserID = o.TID
    LEFT JOIN ServiceProvider s ON u.UserID = s.SpID
    WHERE u.RegDate >= @CutoffMonth;
END
CREATE TABLE PaymentFraudReport (
    ReportMonth DATE PRIMARY KEY,
    TotalPayments INT NOT NULL,
    SuccessfulPayments INT NOT NULL,
    FailedPayments INT NOT NULL,
    ChargebackCount INT NOT NULL,
    SuccessRate DECIMAL(5,2),
    FailureRate DECIMAL(5,2),
    ChargebackRate DECIMAL(5,2)
);

Select *from PaymentFraudReport

Delete from PaymentFraudReport

INSERT INTO PaymentFraudReport (
    ReportMonth,           
    TotalPayments,
    SuccessfulPayments,
    FailedPayments,
    ChargebackCount,
    SuccessRate,
    FailureRate,
    ChargebackRate
)
SELECT
    GETDATE(),  

    COUNT(b.BookingID) AS TotalPayments,  

    COUNT(cb.BookingID) AS SuccessfulPayments, 

    COUNT(b.BookingID) - COUNT(cb.BookingID) AS FailedPayments,

    (
        SELECT COUNT(*) 
        FROM Refund r
        INNER JOIN CompletedBooking cb2 ON r.BookingID = cb2.BookingID
    ) AS ChargebackCount, 

    CASE 
        WHEN COUNT(b.BookingID) > 0 
        THEN CAST(COUNT(cb.BookingID) * 100.0 / COUNT(b.BookingID) AS DECIMAL(5,2))
        ELSE 0
    END AS SuccessRate,

    CASE 
        WHEN COUNT(b.BookingID) > 0 
        THEN CAST((COUNT(b.BookingID) - COUNT(cb.BookingID)) * 100.0 / COUNT(b.BookingID) AS DECIMAL(5,2))
        ELSE 0
    END AS FailureRate,

    CASE 
        WHEN COUNT(cb.BookingID) > 0 
        THEN CAST((
            SELECT COUNT(*) 
            FROM Refund r
            INNER JOIN CompletedBooking cb2 ON r.BookingID = cb2.BookingID
        ) * 100.0 / COUNT(cb.BookingID) AS DECIMAL(5,2))
        ELSE 0
    END AS ChargebackRate
FROM Booking b
LEFT JOIN CompletedBooking cb 
    ON b.BookingID = cb.BookingID
WHERE b.Status = 'Completed';