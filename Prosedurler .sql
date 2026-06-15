-- login işlemi için prosedur
CREATE PROCEDURE sp_Login
    @Mail NVARCHAR(100),
    @Password NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.UserId,
        u.Mail,
        u.Role,
        u.PasswordChanged,

        -- Bayi
        b.BayiId,
        b.Latitude AS BayiLatitude,
        b.Longitude AS BayiLongitude,

        -- Customer
        c.CustomerId,
        c.Latitude AS CustomerLatitude,
        c.Longitude AS CustomerLongitude,

        -- Manager
        m.ManagerId,
        m.Latitude AS ManagerLatitude,
        m.Longitude AS ManagerLongitude

    FROM Users u
    LEFT JOIN Bayis b ON b.UserId = u.UserId
    LEFT JOIN Customers c ON c.UserId = u.UserId
    LEFT JOIN Managers m ON m.UserId = u.UserId

    WHERE u.Mail = @Mail
      AND u.Password = @Password
      AND u.IsDeleted = 0
END
GO



-- zorunlu ilk şifre değişim proseduru
CREATE PROCEDURE sp_UpdatePassword
    @UserId INT,
    @NewPassword NVARCHAR(100)
AS
BEGIN
    UPDATE Users
    SET Password = @NewPassword,
        PasswordChanged = 1
    WHERE UserId = @UserId;
END
GO



-- şifre değiştirme proseduru
CREATE PROCEDURE sp_ChangePassword
    @UserId INT,
    @CurrentPassword NVARCHAR(100),
    @NewPassword NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kullanıcı ve mevcut şifre kontrolü
    IF EXISTS (
        SELECT 1
        FROM Users
        WHERE UserId = @UserId
          AND LTRIM(RTRIM(Password)) = LTRIM(RTRIM(@CurrentPassword))
    )
    BEGIN
        UPDATE Users
        SET Password = @NewPassword
        WHERE UserId = @UserId;

        SELECT 1 AS Result;
    END
    ELSE
    BEGIN
        SELECT 0 AS Result;
    END
END
GO



 -- Müşteri Ekleme Proseduru
CREATE PROCEDURE sp_CreateCustomer
     @Mail NVARCHAR(100),
     @Password NVARCHAR(100),
     @Name NVARCHAR(150),
     @LastName NVARCHAR(150),
     @Status NVARCHAR(10) = 'active',
     @Role NVARCHAR(20) = 'customer',
     @Phone NVARCHAR(20)
AS 
BEGIN 
   SET NOCOUNT ON;

   BEGIN TRY BEGIN TRANSACTION;

     INSERT INTO Users (Mail,Password,Role,Status,PasswordChanged) 
     VALUES (@Mail,@Password,@Role,@Status,0);

     DECLARE @NewUserId INT = SCOPE_IDENTITY();

     INSERT INTO Customers (UserId,Name,LastName,Phone)
     VALUES (@NewUserId,@Name,@LastName,@Phone);
     
     COMMIT TRANSACTION;
   END TRY 
   BEGIN CATCH
         ROLLBACK TRANSACTION;
         THROW;
   END CATCH
END
GO



-- Bayilik Ekleme Proseduru
CREATE PROCEDURE sp_CreateBayi
     @Mail NVARCHAR(100),
     @Password NVARCHAR(100),
     @Name NVARCHAR(150),
     @LastName NVARCHAR(150),
     @Status NVARCHAR(10) = 'active',
     @Role NVARCHAR(20) = 'bayi',
     @Phone NVARCHAR(20),
     @Title NVARCHAR(150)
AS 
BEGIN 
   SET NOCOUNT ON;

   BEGIN TRY BEGIN TRANSACTION;

     INSERT INTO Users(Mail,Password,Role,Status,PasswordChanged) 
     VALUES (@Mail,@Password,@Role,@Status,0);

     DECLARE @NewUserId INT = SCOPE_IDENTITY();

     INSERT INTO Bayis (UserId,Name,LastName,Phone,Title)
     VALUES (@NewUserId,@Name,@LastName,@Phone,@Title);
     
     COMMIT TRANSACTION;
   END TRY 
   BEGIN CATCH
         ROLLBACK TRANSACTION;
         THROW;
   END CATCH
END
GO



-- Müşteri Profili Proseduru
CREATE PROCEDURE sp_CustomerProfile
     @UserId INT 
AS
BEGIN
      SELECT 
      u.UserId,
      u.Mail,
      c.Name,
      c.LastName,
      c.Latitude,
      c.Longitude,
      c.Phone
      FROM Users u INNER JOIN Customers c ON u.UserId = c.UserId
      WHERE u.UserId= @UserId AND u.IsDeleted = 0
END 
GO 



-- Müşteri Profili Güncelleme Proseduru
CREATE PROCEDURE sp_UpdateCustomer
     @UserId INT,
     @Name NVARCHAR(150),
     @LastName NVARCHAR(150),
     @Latitude FLOAT = NULL,
     @Longitude FLOAT = NULL,
     @Phone NVARCHAR(20)
AS
BEGIN
      UPDATE Customers SET Name=@Name,LastName = @LastName,Phone=@Phone,
      Latitude=@Latitude , Longitude=@Longitude
      WHERE UserId = @UserId
END
GO



-- Bayi Profili Proseduru
CREATE PROCEDURE sp_BayiProfile
     @UserId INT 
AS
BEGIN
      SELECT 
      u.UserId,
      b.BayiId,
      u.Mail,
      b.Name ,
      b.LastName,
      b.Phone,
      b.Tc,
      b.City,
      b.Address,
      b.Latitude,
      b.Longitude,
      b.Tax,
      b.TaxNo,
      b.Title
      FROM Users u INNER JOIN Bayis b ON u.UserId = b.UserId
      WHERE u.UserId= @UserId AND u.IsDeleted = 0
END 
GO 



-- Bayi Profili Güncelleme Proseduru
CREATE PROCEDURE sp_UpdateBayi
     @UserId INT,
     @Name NVARCHAR(150),
     @LastName NVARCHAR(150),
     @Phone NVARCHAR(20),
     @Tc NVARCHAR(11),
     @Tax NVARCHAR(150),
     @TaxNo NVARCHAR(150),
     @City NVARCHAR(50),
     @Address NVARCHAR(255),
     @Title NVARCHAR(150),
     @Latitude FLOAT = NULL,
     @Longitude FLOAT = NULL
AS
BEGIN
      UPDATE Bayis SET
      Name=@Name,LastName = @LastName,Phone=@Phone,Tc=@Tc,Tax=@Tax,TaxNo=@TaxNo,City=@City,Address=@Address,Title=@Title,
      Latitude=@Latitude,Longitude=@Longitude
      WHERE UserId = @UserId
END
GO



-- Yönetici Profili Proseduru
CREATE PROCEDURE sp_ManagerProfile
     @UserId INT 
AS
BEGIN
      SELECT 
      u.UserId,
      u.Mail,
      m.Name,
      m.LastName,
      m.Latitude,
      m.Longitude,
      m.Phone
      FROM Users u INNER JOIN Managers m ON u.UserId = m.UserId
      WHERE m.UserId= @UserId AND u.IsDeleted = 0
END 
GO 



-- Yönetici Profili Güncelleme Proseduru
CREATE PROCEDURE sp_UpdateManager
     @UserId INT,
     @Name NVARCHAR(150),
     @LastName NVARCHAR(150),
     @Phone NVARCHAR(20),
     @Latitude FLOAT = NULL,
     @Longitude FLOAT = NULL
AS
BEGIN
      UPDATE Managers SET
      Name=@Name,LastName = @LastName,Phone=@Phone, Latitude=@Latitude,Longitude=@Longitude
      WHERE UserId = @UserId
END
GO



-- Gelir Kaydı Prosedürü
CREATE PROCEDURE sp_CreateIncome
     @UserId INT,
     @AppointmentId INT,
     @PaymentId INT,
     @Price DECIMAL(10,2),
     @Description NVARCHAR(500),
     @IncomeDate DATETIME,
     @CreatedAt DATETIME
AS
BEGIN
     SET NOCOUNT ON;

     BEGIN TRY

        INSERT INTO Incomes
        ( UserId, AppointmentId, PaymentId, Price, Description, IncomeDate, CreatedAt )
        VALUES
        ( @UserId, @AppointmentId, @PaymentId, @Price, @Description, @IncomeDate, @CreatedAt );

     END TRY

     BEGIN CATCH
          THROW;
     END CATCH
END
GO



-- Gelir Bilgilerini Getirme Prosedürü
CREATE PROCEDURE sp_InfoIncome
     @IncomeId INT
AS
BEGIN

    SET NOCOUNT ON;

    SELECT * FROM Incomes WHERE IncomeId = @IncomeId AND Status = 'active';

END
GO



-- Gelir Güncelleme Prosedürü
CREATE PROCEDURE sp_UpdateIncome
     @IncomeId INT,
     @UserId INT,
     @AppointmentId INT,
     @PaymentId INT,
     @Price DECIMAL(10,2),
     @Description NVARCHAR(500),
     @IncomeDate DATETIME
AS
BEGIN
     SET NOCOUNT ON;

     BEGIN TRY

        UPDATE Incomes
        SET
            UserId = @UserId,
            AppointmentId = @AppointmentId,
            PaymentId = @PaymentId,
            Price = @Price,
            Description = @Description,
            IncomeDate = @IncomeDate
        WHERE IncomeId = @IncomeId;

     END TRY

     BEGIN CATCH
          THROW;
     END CATCH
END
GO



-- Geliri Pasif Yapma Prosedurü
CREATE PROCEDURE sp_DeleteIncome
    @IncomeId INT
AS
BEGIN

    SET NOCOUNT ON;

    UPDATE Incomes SET Status = 'passive' WHERE IncomeId = @IncomeId;
END
GO



-- Gider Kaydı Prosedürü
CREATE PROCEDURE sp_CreateExpense
     @UserId INT,
     @PaymentId INT,
     @Title NVARCHAR(100),
     @Price DECIMAL(10,2),
     @Description NVARCHAR(500),
     @ExpenseDate DATETIME,
     @CreatedAt DATETIME
AS
BEGIN
     SET NOCOUNT ON;

     BEGIN TRY

        INSERT INTO Expenses
        ( UserId, PaymentId, Title, Price, Description, ExpenseDate, CreatedAt )
        VALUES
        ( @UserId, @PaymentId, @Title, @Price, @Description, @ExpenseDate, @CreatedAt );
     END TRY

     BEGIN CATCH
          THROW;
     END CATCH
END
GO



-- Gider Bilgisi Getirme Proseduru
CREATE PROCEDURE sp_ExpenseInfo
     @ExpenseId INT
AS
BEGIN

    SET NOCOUNT ON;

    SELECT * FROM Expenses WHERE ExpenseId = @ExpenseId AND Status = 'active';

END
GO



-- Gider Güncelleme Prosedürü
CREATE PROCEDURE sp_UpdateExpense
     @ExpenseId INT,
     @UserId INT,
     @PaymentId INT,
     @Title NVARCHAR(100),
     @Price DECIMAL(10,2),
     @Description NVARCHAR(500),
     @ExpenseDate DATETIME
AS
BEGIN
     SET NOCOUNT ON;

     BEGIN TRY

        UPDATE Expenses
        SET
            UserId = @UserId,
            PaymentId = @PaymentId,
            Title = @Title,
            Price = @Price,
            Description = @Description,
            ExpenseDate = @ExpenseDate
        WHERE ExpenseId = @ExpenseId;

     END TRY

     BEGIN CATCH
          THROW;
     END CATCH
END
GO



-- Gideri Pasif Yapma Prosedurü
CREATE PROCEDURE sp_DeleteExpense
    @ExpenseId INT
AS
BEGIN

    SET NOCOUNT ON;

    UPDATE Expenses SET Status = 'passive' WHERE ExpenseId = @ExpenseId;

END
GO



-- Gelir-Gider Listeleme Prosedurü
CREATE PROCEDURE sp_GetFinanceList
    @UserId INT,
    @FinanceType NVARCHAR(10) = 'Tümü',
    @DateFilter NVARCHAR(20) = 'Tümü'
AS
BEGIN

    SET NOCOUNT ON;

    SET @FinanceType = ISNULL(@FinanceType, 'Tümü');
    SET @DateFilter = ISNULL(@DateFilter, 'Tümü');


    SELECT *
    FROM
    (

        -- GELİRLER
        SELECT
            IncomeId AS Id,
            'Income' AS Type,
            Description,
            Price,
            IncomeDate AS Date
        FROM Incomes
        WHERE UserId = @UserId
        AND Status = 'active'
        AND (@FinanceType = 'Tümü' OR @FinanceType = 'Income')
        AND
        (
            @DateFilter = 'Tümü'

            OR (@DateFilter = 'Bugün'
                AND CAST(IncomeDate AS DATE) = CAST(GETDATE() AS DATE))

            OR (@DateFilter = 'Bu Hafta'
                AND DATEPART(WEEK, IncomeDate) = DATEPART(WEEK, GETDATE())
                AND YEAR(IncomeDate) = YEAR(GETDATE()))

            OR (@DateFilter = 'Bu Ay'
                AND MONTH(IncomeDate) = MONTH(GETDATE())
                AND YEAR(IncomeDate) = YEAR(GETDATE()))
        )


        UNION ALL


        -- GİDERLER
        SELECT
            ExpenseId AS Id,
            'Expense' AS Type,
            Description,
            Price,
            ExpenseDate AS Date
        FROM Expenses
        WHERE UserId = @UserId
        AND Status = 'active'
        AND (@FinanceType = 'Tümü' OR @FinanceType = 'Expense')
        AND
        (
            @DateFilter = 'Tümü'

            OR (@DateFilter = 'Bugün'
                AND CAST(ExpenseDate AS DATE) = CAST(GETDATE() AS DATE))

            OR (@DateFilter = 'Bu Hafta'
                AND DATEPART(WEEK, ExpenseDate) = DATEPART(WEEK, GETDATE())
                AND YEAR(ExpenseDate) = YEAR(GETDATE()))

            OR (@DateFilter = 'Bu Ay'
                AND MONTH(ExpenseDate) = MONTH(GETDATE())
                AND YEAR(ExpenseDate) = YEAR(GETDATE()))
        )

    ) AS FinanceList

    ORDER BY Date DESC;

END
GO



-- Bayi DropDown için Prosedur
CREATE PROCEDURE sp_DropDownBayi
AS 
BEGIN
     SELECT BayiId,Title FROM Bayis WHERE Status='active'
END
GO



--Bina DropDown için Prosedur
CREATE PROCEDURE sp_DropDownBuilding
    @UserId INT
AS
BEGIN
    SELECT b.BuildingId, b.Title FROM Buildings b
    INNER JOIN Customers c ON b.CustomerId = c.CustomerId
    WHERE c.UserId = @UserId
END
GO



--Müşteri DropDown için Prosedur
CREATE PROCEDURE sp_DropDownCustomer
AS 
BEGIN
     SELECT
     c.UserId,
     c.CustomerId,
     c.Name + ' ' + c.LastName AS FullName
    FROM Customers c
    INNER JOIN Users u ON c.UserId = u.UserId
    WHERE u.IsDeleted = 0 AND u.Status = 'active'
END
GO



-- Randevuları Listelemek için Prosesdur
CREATE PROCEDURE sp_AppointmentList
    @CustomerId INT = NULL,
    @BayiId INT = NULL,
    @Status NVARCHAR(20) = NULL,
    @DateType NVARCHAR(20) = NULL,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @StartDate IS NULL
        SET @StartDate = DATEADD(MONTH, -1, GETDATE());

    IF @EndDate IS NULL
        SET @EndDate = DATEADD(MONTH, 1, GETDATE());

    SET @Status = NULLIF(@Status, '');
    SET @DateType = NULLIF(@DateType, '');

    SELECT
        a.AppointmentId,
        a.AppDate,
        a.AppTime,
        a.Price,
        a.Description,
        a.Status,
        a.CreatedAt,
        a.UpdatedAt,

        b.BayiId,
        b.Title AS BayiTitle,
        b.Name + ' ' + b.LastName AS BayiName,

        bu.BuildingId,
        bu.Title AS BuildingTitle,
        bu.Address,
        bu.City,
        bu.Latitude,
        bu.Longitude,

        c.CustomerId,
        c.Name + ' ' + c.LastName AS CustomerName,
        c.Phone,

        a.Rating 
    FROM Appointments a

    INNER JOIN Bayis b ON a.BayiId = b.BayiId
    INNER JOIN Buildings bu ON a.BuildingId = bu.BuildingId
    INNER JOIN Customers c ON bu.CustomerId = c.CustomerId

    WHERE
        (@CustomerId IS NULL OR c.CustomerId = @CustomerId)
        AND (@BayiId IS NULL OR a.BayiId = @BayiId)
        AND (@Status IS NULL OR a.Status = @Status)

        AND a.AppDate BETWEEN @StartDate AND @EndDate

        AND (
            @DateType IS NULL
            OR (@DateType = 'past' AND a.AppDate < CAST(GETDATE() AS DATE))
            OR (@DateType = 'future' AND a.AppDate >= CAST(GETDATE() AS DATE))
            OR (@DateType = 'today' AND a.AppDate = CAST(GETDATE() AS DATE))
        )

    ORDER BY a.AppDate DESC, a.AppTime DESC;
END
GO



-- Randevu durumunu güncelleme proseduru
CREATE PROCEDURE sp_UpdateStatusAppointment
    @AppointmentId INT,
    @Status NVARCHAR(20)
AS
BEGIN

   UPDATE Appointments SET Status = @Status WHERE AppointmentId = @AppointmentId

END
GO



-- Video eklemek için Proseduru
CREATE PROCEDURE sp_CreateVideo
     @Title NVARCHAR(150),
     @Description NVARCHAR(500),
     @Duration INT,
     @Url NVARCHAR(255),
     @VideoType NVARCHAR(50),
     @CreatedAt DATETIME
AS 
BEGIN
    INSERT INTO Videos( Title, Description, Duration, Url, VideoType, CreatedAt, Status) 
    VALUES ( @Title, @Description, @Duration, @Url, @VideoType, @CreatedAt, 'active')
END
GO



-- Video Listeleme için Prosedur
CREATE PROCEDURE sp_VideoList
AS
BEGIN
    SELECT  VideoId, Title, Description, Duration, Url, VideoType, CreatedAt
    FROM Videos WHERE Status='active'
    ORDER BY CreatedAt DESC
END
GO



-- Kullanıcı listeleme için prosedur 
CREATE PROCEDURE sp_UserList
    @Role NVARCHAR(20) = NULL,      
    @Status NVARCHAR(10) = NULL     
AS
BEGIN
    SET NOCOUNT ON;

    SET @Role = NULLIF(@Role, '');
    SET @Status = NULLIF(@Status, '');

    SELECT 
        u.UserId,
        TRIM(
            COALESCE(m.Name, b.Name, c.Name, '') + ' ' +
            COALESCE(m.LastName, b.LastName, c.LastName, '')
        ) AS FullName,
        u.Mail,
        u.RegisterDate,
        u.LastLogin,
        u.Role,
        u.Status,
        b.Phone AS BayiPhone,
        b.Title AS BayiTitle,
        b.TaxNo AS BayiTaxNo,
        b.CreatedAt AS BayiCreatedAt,
        c.Phone AS CustomerPhone

    FROM Users u
    LEFT JOIN Managers m ON u.UserId = m.UserId
    LEFT JOIN Bayis b ON u.UserId = b.UserId
    LEFT JOIN Customers c ON u.UserId = c.UserId

    WHERE (@Role IS NULL OR u.Role = @Role)
      AND (@Status IS NULL OR u.Status = @Status)

    ORDER BY u.Role, FullName;
END
GO



-- Bayi Listeleme ve Filtreleme Prosedürü
CREATE PROCEDURE sp_BayiList
    @Name NVARCHAR(150) = NULL,
    @LastName NVARCHAR(150) = NULL,
    @City NVARCHAR(50) = NULL,
    @Status NVARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SET @Name = NULLIF(@Name, '');
    SET @LastName = NULLIF(@LastName, '');
    SET @City = NULLIF(@City, '');
    SET @Status = NULLIF(@Status, '');

    SELECT 
        b.BayiId,
        u.Mail,
        b.Name,
        b.LastName,
        (b.Name + ' ' + b.LastName) AS FullName,
        b.Title,
        b.Tc,
        b.Tax,
        b.TaxNo,
        b.Phone,
        b.City,
        b.Address,
        b.Latitude,
        b.Longitude,
        b.IsMainBayi,
        b.Status ,
        b.CreatedAt
    FROM Bayis b
    INNER JOIN Users u ON b.UserId = u.UserId
    WHERE (@Name IS NULL OR b.Name LIKE '%' + @Name + '%')
      AND (@LastName IS NULL OR b.LastName LIKE '%' + @LastName + '%')
      AND (@City IS NULL OR b.City = @City)
      AND (@Status IS NULL OR b.Status = @Status)
      AND u.IsDeleted = 0
    ORDER BY b.CreatedAt DESC;
END
GO



-- video izlemeye baslandigi an calisacak prosedur
CREATE PROCEDURE sp_StartVideoProgress
    @BayiId INT,
    @VideoId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Eğer kayıt yoksa oluştur
    IF NOT EXISTS (
        SELECT 1 
        FROM VideoProgress 
        WHERE BayiId = @BayiId AND VideoId = @VideoId
    )
    BEGIN
        INSERT INTO VideoProgress ( BayiId, VideoId, WatchedDuration, LastWatched, CompletionRate, IsCompleted )
        VALUES ( @BayiId, @VideoId, 0, 0, 0, 0 );
    END
END
GO



-- video izlendigi anlarda izlenme bilgilerinin güncellendigi prosedur 
CREATE PROCEDURE sp_UpdateVideoProgress
    @BayiId INT,
    @VideoId INT,
    @WatchedDuration INT,
    @TotalDuration INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CompletionRate DECIMAL(5,2)

    SET @CompletionRate = 
        CASE 
            WHEN @TotalDuration = 0 THEN 0
            ELSE (CAST(@WatchedDuration AS FLOAT) / @TotalDuration) * 100
        END

    UPDATE VideoProgress
    SET 
        WatchedDuration = @WatchedDuration,
        LastWatched = @WatchedDuration,
        CompletionRate = @CompletionRate,
        IsCompleted = CASE 
                        WHEN @CompletionRate >= 90 THEN 1 
                        ELSE 0 
                      END
    WHERE BayiId = @BayiId AND VideoId = @VideoId
END
GO



-- video detay proseduru
CREATE PROCEDURE sp_GetVideoProgress
    @VideoId INT,
    @BayiId INT = NULL,
    @IsCompleted BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        b.BayiId,
        b.UserId,
        vp.VideoId,
        b.Title,
        vp.WatchedDuration,
        vp.TotalDuration,
        vp.CompletionRate,
        vp.IsCompleted
    FROM VideoProgress vp
    INNER JOIN Bayis b ON vp.BayiId = b.BayiId
    WHERE vp.VideoId = @VideoId
      AND (@BayiId IS NULL OR b.BayiId = @BayiId)
      AND (@IsCompleted IS NULL OR vp.IsCompleted = @IsCompleted)
    ORDER BY b.Title
END
GO



-- Videoyu pasif yapan prosedür
CREATE PROCEDURE sp_DeleteVideo
    @VideoId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Videos
    SET Status = 'passive'
    WHERE VideoId = @VideoId;

END
GO



-- bina ekleme proseduru
CREATE PROCEDURE sp_CreateBuilding  
    @CustomerId INT,  
    @Title NVARCHAR(150),  
    @Address NVARCHAR(150),  
    @City NVARCHAR(100),
    @Latitude FLOAT = NULL,
    @Longitude FLOAT = NULL
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    BEGIN TRY  
        BEGIN TRANSACTION;  
  
        INSERT INTO Buildings 
        ( CustomerId, Title, Address, City, Latitude, Longitude, CreatedAt, IsDeleted )  
        VALUES 
        ( @CustomerId, @Title, @Address, @City, @Latitude, @Longitude, GETDATE(), 0 );  
  
        COMMIT TRANSACTION;  
    END TRY  
    BEGIN CATCH  
        ROLLBACK TRANSACTION;  
        THROW;  
    END CATCH  
END    
GO



-- Bina Silme Proseduru  
CREATE PROCEDURE sp_DeleteBuilding  
     @BuildingId INT  
AS  
BEGIN  
      UPDATE Buildings SET IsDeleted=1 WHERE BuildingId = @BuildingId   
END  
GO



-- bina güncelleme prsoeduru
CREATE PROCEDURE sp_UpdateBuilding  
    @BuildingId INT,
    @Title NVARCHAR(150),  
    @Address NVARCHAR(150),  
    @City NVARCHAR(100),
    @Latitude FLOAT = NULL,
    @Longitude FLOAT = NULL
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    BEGIN TRY  
        BEGIN TRANSACTION;  
  
        UPDATE Buildings  
        SET  
            Title = @Title,  
            Address = @Address,  
            City = @City,  
            Latitude = @Latitude,
            Longitude = @Longitude  
        WHERE BuildingId = @BuildingId;  
  
        COMMIT TRANSACTION;  
    END TRY  
    BEGIN CATCH  
        ROLLBACK TRANSACTION;  
        THROW;  
    END CATCH  
END  
GO



-- bina listelemek için prosedur
CREATE PROCEDURE sp_GetBuilding
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        b.BuildingId,
        b.Title,
        b.Address,
        b.City,
        b.CreatedAt,
        b.Latitude,
        b.Longitude
    FROM Buildings b
    INNER JOIN Customers c ON b.CustomerId = c.CustomerId
    WHERE c.UserId = @UserId
      AND b.CreatedAt IS NOT NULL
END
GO



-- bildirim oluşturma proseduru
CREATE PROCEDURE sp_CreateNotification
    @UserId INT,
    @Title NVARCHAR(255),
    @Body NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Notifications (UserId, Title, Body, IsRead, CreatedAt)
    VALUES (@UserId, @Title, @Body, 0, GETDATE());
END
GO



-- bildirimi okundu olarak güncelleme proseduru
CREATE PROCEDURE sp_UpdateNotification
    @NotId INT
AS
BEGIN
    UPDATE Notifications
    SET IsRead = 1
    WHERE NotId = @NotId;
END
GO


-- bildirimleri göster proseduru
CREATE PROCEDURE sp_GetUnreadNotifications
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT  NotId, UserId, Title, Body, IsRead, CreatedAt
    FROM Notifications WHERE UserId = @UserId
      AND IsRead = 0 ORDER BY CreatedAt DESC;
END
GO


-- okunmuş bildirimleri gösterme proseduru
CREATE PROCEDURE sp_GetReadNotifications
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT NotId, UserId, Title, Body, IsRead, CreatedAt
    FROM Notifications WHERE UserId = @UserId
      AND IsRead = 1 ORDER BY CreatedAt DESC;
END
GO



-- Customer Listeleme ve Filtreleme Prosedürü
CREATE PROCEDURE sp_CustomerList
    @Name NVARCHAR(150) = NULL,
    @LastName NVARCHAR(150) = NULL,
    @Status NVARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SET @Name = NULLIF(@Name, '');
    SET @LastName = NULLIF(@LastName, '');
    SET @Status = NULLIF(@Status, '');

    SELECT
        c.CustomerId,
        c.UserId,
        u.Mail,
        c.Name,
        c.LastName,
        (c.Name + ' ' + c.LastName) AS FullName,
        c.Phone,
        c.Latitude,
        c.Longitude,
        c.Status,
        c.CreatedAt
    FROM Customers c
    INNER JOIN Users u ON c.UserId = u.UserId
    WHERE (@Name IS NULL OR c.Name LIKE '%' + @Name + '%')
      AND (@LastName IS NULL OR c.LastName LIKE '%' + @LastName + '%')
      AND (@Status IS NULL OR c.Status = @Status)
      AND u.IsDeleted = 0
    ORDER BY c.CreatedAt DESC;
END
GO



-- bayi raporları için prosedur
CREATE PROCEDURE sp_BayiReport
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        b.BayiId,

        CONCAT(b.Name, ' ', b.LastName) AS BayiName,

        b.City,
        b.Status,

        COUNT(DISTINCT bu.CustomerId) AS CustomerCount,

        COUNT(DISTINCT a.AppointmentId) AS AppointmentCount

    FROM Bayis b

    LEFT JOIN Appointments a
        ON a.BayiId = b.BayiId

    LEFT JOIN Buildings bui
        ON bui.BuildingId = a.BuildingId

    LEFT JOIN Customers bu
        ON bu.CustomerId = bui.CustomerId

    GROUP BY
        b.BayiId,
        b.Name,
        b.LastName,
        b.City,
        b.Status
END
GO



-- müşteri raporları için prosedur
CREATE PROCEDURE sp_CustomerReport
AS
BEGIN
    SELECT 
        c.CustomerId AS customerId,
        c.Name + ' ' + c.LastName AS name,
        c.Phone,
        c.City,
        
        COUNT(a.AppointmentId) AS appointment,
        
        ISNULL(CONVERT(VARCHAR, MAX(a.CreatedAt), 120), 'Yok') AS lastActive,

        CASE 
            WHEN COUNT(a.AppointmentId) >= 5 THEN 90
            WHEN COUNT(a.AppointmentId) >= 3 THEN 70
            WHEN COUNT(a.AppointmentId) >= 1 THEN 50
            ELSE 20
        END AS score

    FROM Customers c
    LEFT JOIN Buildings b ON b.CustomerId = c.CustomerId
    LEFT JOIN Appointments a ON a.BuildingId = b.BuildingId

    GROUP BY 
        c.CustomerId, c.Name, c.LastName, c.Phone, c.City
END
GO



-- randevu raporları için prosedur
CREATE PROCEDURE sp_AppointmentReport
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        a.AppointmentId,
        c.Name + ' ' + c.LastName AS CustomerName,
        b.Name AS DealerName,
        b.City,
        CAST(a.AppDate AS DATETIME) + CAST(a.AppTime AS DATETIME) AS AppDateTime,
        a.Status,
        a.Rating,


        (SELECT COUNT(*) FROM Appointments) AS TotalAppointments,
        (SELECT COUNT(*) FROM Appointments WHERE Status = 'completed') AS CompletedCount,
        (SELECT COUNT(*) FROM Appointments WHERE Status = 'pending') AS PendingCount,
        (SELECT COUNT(*) FROM Appointments WHERE Status = 'cancelled') AS CancelledCount,

        (SELECT COUNT(*) FROM Appointments ap 
         WHERE ap.AppDate = a.AppDate) AS DailyCount

    FROM Appointments a
    INNER JOIN Buildings bd ON a.BuildingId = bd.BuildingId
    INNER JOIN Customers c ON bd.CustomerId = c.CustomerId
    INNER JOIN Bayis b ON a.BayiId = b.BayiId

    ORDER BY a.AppDate DESC;
END
GO



-- video raporları için prosedur
CREATE PROCEDURE sp_VideoReport
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        v.VideoId,
        v.Title,

        COUNT(vp.ProgressId) AS Views,

        CAST(ISNULL(AVG(CAST(vp.CompletionRate AS FLOAT)), 0) AS DECIMAL(5,2)) AS AvgCompletion,

        SUM(CASE WHEN vp.IsCompleted = 1 THEN 1 ELSE 0 END) AS CompletedCount

    FROM Videos v
    LEFT JOIN VideoProgress vp ON v.VideoId = vp.VideoId

    WHERE v.Status = 'active'

    GROUP BY v.VideoId, v.Title
END
GO



-- finans raporları için prosedur
CREATE PROCEDURE sp_FinanceReport
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        'Gelir' AS Title,
        Price AS Amount,
        'income' AS Type
    FROM Incomes

    UNION ALL

    SELECT 
        Title,
        Price AS Amount,
        'expense' AS Type
    FROM Expenses;
END
GO



-- randevu degerlendirme proseduru
CREATE PROCEDURE sp_RateAppointment
(
    @AppointmentId INT,
    @Rating INT
)
AS
BEGIN
    SET NOCOUNT ON;

    -- sadece tamamlanan randevular puanlanabilir
    IF NOT EXISTS (
        SELECT 1
        FROM Appointments
        WHERE AppointmentId = @AppointmentId
        AND Status = 'completed'
    )
    BEGIN
        RAISERROR('Sadece tamamlanan randevular puanlanabilir.', 16, 1);
        RETURN;
    END


    IF EXISTS (
        SELECT 1
        FROM Appointments
        WHERE AppointmentId = @AppointmentId
        AND Rating IS NOT NULL
    )
    BEGIN
        RAISERROR('Bu randevu zaten puanlanmış.', 16, 1);
        RETURN;
    END

    UPDATE Appointments
    SET
        Rating = @Rating,
        UpdatedAt = GETDATE()
    WHERE AppointmentId = @AppointmentId;

END
GO



-- dünki randevuyu getiren prosedur
CREATE PROCEDURE sp_GetYesterdayUnratedAppointment
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        a.AppointmentId,
        a.AppDate,
        a.AppTime,
        a.Status,


        c.CustomerId,
        c.Name + ' ' + c.LastName AS CustomerName,
        c.Phone,

        b.BayiId,
        b.Name + ' ' + b.LastName AS BayiName,

        bu.BuildingId,
        bu.Title AS BuildingTitle,
        bu.Address,
        bu.City,
        bu.Latitude,
        bu.Longitude

    FROM Appointments a
    INNER JOIN Customers c ON c.CustomerId = (
        SELECT CustomerId 
        FROM Buildings 
        WHERE BuildingId = a.BuildingId
    )
    INNER JOIN Bayis b ON b.BayiId = a.BayiId
    INNER JOIN Buildings bu ON bu.BuildingId = a.BuildingId

    WHERE 
        a.Status = 'completed'
        AND a.Rating IS NULL
        AND CAST(a.AppDate AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)

    ORDER BY a.AppDate DESC;
END
GO



-- Günün aktif randevusunu getiren prosedür
CREATE PROCEDURE sp_GetMyActiveAppointment
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Role NVARCHAR(20);
    DECLARE @BayiId INT = NULL;
    DECLARE @CustomerId INT = NULL;

    -- Kullanıcının rolünü bul
    SELECT @Role = Role
    FROM Users
    WHERE UserId = @UserId;

    -- Eğer bayi ise BayiId getir
    IF @Role = 'bayi'
    BEGIN
        SELECT @BayiId = BayiId
        FROM Bayis
        WHERE UserId = @UserId;
    END

    -- Eğer customer ise CustomerId getir
    IF @Role = 'customer'
    BEGIN
        SELECT @CustomerId = CustomerId
        FROM Customers
        WHERE UserId = @UserId;
    END

    DECLARE @Now DATETIME = GETDATE();

    SELECT TOP 1
        a.AppointmentId,
        a.BayiId,
        a.BuildingId,
        a.AppDate,
        a.AppTime,
        a.Status,

        -- Randevu tarihi + saati
        CAST(a.AppDate AS DATETIME) + CAST(a.AppTime AS DATETIME)
            AS AppointmentDate,

        -- Chat başlangıcı (15 dk önce)
        DATEADD(
            MINUTE,
            -15,
            CAST(a.AppDate AS DATETIME) + CAST(a.AppTime AS DATETIME)
        ) AS ChatStart,

        -- Chat bitişi (2 saat sonra)
        DATEADD(
            HOUR,
            2,
            CAST(a.AppDate AS DATETIME) + CAST(a.AppTime AS DATETIME)
        ) AS ChatEnd,

        -- Chat aktif mi?
        CAST(
            CASE
                WHEN @Now BETWEEN
                    DATEADD(
                        MINUTE,
                        -15,
                        CAST(a.AppDate AS DATETIME)
                        + CAST(a.AppTime AS DATETIME)
                    )
                AND
                    DATEADD(
                        HOUR,
                        2,
                        CAST(a.AppDate AS DATETIME)
                        + CAST(a.AppTime AS DATETIME)
                    )
                THEN 1
                ELSE 0
            END
        AS BIT) AS CanChat

    FROM Appointments a

    WHERE a.Status = 'approved'

    AND (
        (@Role = 'bayi' AND a.BayiId = @BayiId)

        OR

        (
            @Role = 'customer'
            AND a.BuildingId IN (
                SELECT BuildingId
                FROM Buildings
                WHERE CustomerId = @CustomerId
            )
        )
    )

    ORDER BY a.AppDate DESC;
END
GO


SELECT *
FROM Bayis
WHERE UserId = 7;  -- giriş yaptığın kullanıcı

EXEC sp_GetMyActiveAppointment @UserId = 7;

select * from Users
select * from Buildings
select * from Customers
select * from Bayis
select * from Incomes
select * from Expenses
select * from Appointments
select * from VideoProgress
select * from Videos


DECLARE @UserId INT = 7;

SELECT 
    u.UserId,
    u.Role,
    b.BayiId
FROM Users u
LEFT JOIN Bayis b ON b.UserId = u.UserId
WHERE u.UserId = @UserId;

SELECT *
FROM Appointments
WHERE BayiId = 1;


delete Users Where UserId = 3

select * from Customers
delete Customers Where UserId = 45
INSERT INTO Appointments (
    BayiId,
    BuildingId,
    AppDate,
    AppTime,
    Price,
    Description,
    Status
)
VALUES (
    1,
    6,
    '2026-06-15',
    '15:15',
     4100.00,
    'Otomatik oluşturulan randevu',
    'approved'
);

select * from Customers 

delete Appointments WHERE AppointmentId= 10;

UPDATE Customers SET LastName='Bender' WHERE UserId= 51