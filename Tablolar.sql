CREATE DATABASE ERPSql;

-- Kullanýcýlar Tablosu
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Mail NVARCHAR(150) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    PasswordChanged BIT NOT NULL DEFAULT 0,
    Role NVARCHAR(20) NOT NULL CHECK (role IN ('manager','bayi','customer')),
    RegisterDate DATETIME DEFAULT GETDATE(),
    LastLogin DATETIME NULL,
    Status NVARCHAR(10) DEFAULT 'active' CHECK (status IN ('active','passive')),
    IsDeleted BIT DEFAULT 0
);
GO


-- Bayiler Tablosu
CREATE TABLE Bayis(
    BayiId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT UNIQUE NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    LastName NVARCHAR(150) NOT NULL,
    Title NVARCHAR(150) NOT NULL,
    Tc CHAR(11),
    Tax NVARCHAR(150),
    TaxNo NVARCHAR(50),
    Phone NVARCHAR(20),
    City NVARCHAR(50),
    Address NVARCHAR(255),
    Latitude FLOAT NULL, -- enlem
    Longitude FLOAT NULL, -- boylam
    IsMainBayi BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(10) DEFAULT 'active' CHECK (status IN ('active','passive')),
    CONSTRAINT FK_Bayi_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
GO


-- Müþteriler Tablosu
CREATE TABLE Customers(
    CustomerId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT UNIQUE NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    LastName NVARCHAR(150) NOT NULL,
    Latitude FLOAT NULL, -- enlem
    Longitude FLOAT NULL, -- boylam
    Phone NVARCHAR(20),
    Status NVARCHAR(10) DEFAULT 'active',
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Customers_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
GO


-- Yöneticiler Tablosu
CREATE TABLE Managers(
    ManagerId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT UNIQUE NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    LastName NVARCHAR(150) NOT NULL,
    Latitude FLOAT NULL, -- enlem
    Longitude FLOAT NULL, -- boylam
    Phone NVARCHAR(20),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Manager_Users FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
GO



-- Binalar Tablosu
CREATE TABLE Buildings(
    BuildingId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT NOT NULL,
    Title NVARCHAR(150) NOT NULL,
    Address NVARCHAR(150) NOT NULL,
    Latitude FLOAT NULL, -- enlem
    Longitude FLOAT NULL, -- boylam
    City NVARCHAR(100) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Buildings_Customers FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId)
);
GO



-- Randevular Tablosu
CREATE TABLE Appointments(
    AppointmentId INT IDENTITY(1,1) PRIMARY KEY,
    BayiId INT NOT NULL,
    BuildingId INT NOT NULL,
    AppDate DATE NOT NULL,
    AppTime TIME,
    Price DECIMAL(10,2) NOT NULL,
    Description NVARCHAR(500),
    Rating INT NULL CHECK (Rating BETWEEN 1 AND 5);
    Status NVARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending','approved','completed','cancelled','rejected')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL,
    CONSTRAINT FK_Appointment_Bayi FOREIGN KEY (BayiId) REFERENCES Bayis(BayiId),
    CONSTRAINT FK_Appointment_Building FOREIGN KEY (BuildingId) REFERENCES Buildings(BuildingId)
);
GO


-- Videolar Tablosu
CREATE TABLE Videos(
    VideoId INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500),
    Duration INT, 
    Url NVARCHAR(255) NOT NULL,
    VideoType NVARCHAR(50),
    CreatedAt DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(10) DEFAULT 'active' CHECK (status IN ('active','passive'))
);
GO



-- Video Ýzleme Takibi Tablosu
CREATE TABLE VideoProgress(
    ProgressId INT IDENTITY(1,1) PRIMARY KEY,
    BayiId INT NOT NULL,
    VideoId INT NOT NULL,
    WatchedDuration INT,
    LastWatched INT,
    TotalDuration INT,
    CompletionRate DECIMAL(5,2),
    IsCompleted BIT DEFAULT 0,
    Status NVARCHAR(10) DEFAULT 'active' CHECK (status IN ('active','passive')),
    CONSTRAINT FK_VideoProgress_Bayi FOREIGN KEY (BayiId) REFERENCES Bayis(BayiId),
    CONSTRAINT FK_VideoProgress_Video FOREIGN KEY (VideoId) REFERENCES Videos(VideoId),
    CONSTRAINT UQ_Bayi_Video UNIQUE (BayiId, VideoId)
);
GO


-- Ödeme Tipleri Tablosu
CREATE TABLE PaymentMethods(
    PaymentId INT IDENTITY(1,1) PRIMARY KEY,
    PaymentMethodType NVARCHAR(50) NOT NULL,
    Status NVARCHAR(10) DEFAULT 'active' CHECK (status IN ('active','passive'))
);
GO



-- Gelirler Tablosu
CREATE TABLE Incomes(
    IncomeId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    AppointmentId INT NULL,
    PaymentId INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Description NVARCHAR(500),
    IncomeDate DATE DEFAULT GETDATE(),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Income_User FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_Income_Appointment FOREIGN KEY (AppointmentId) REFERENCES Appointments(AppointmentId),
    CONSTRAINT FK_Income_Payment FOREIGN KEY (PaymentId) REFERENCES PaymentMethods(PaymentId)
);
GO



-- Giderler Tablosu
CREATE TABLE Expenses(
    ExpenseId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    PaymentId INT NOT NULL,
    Title NVARCHAR(100),
    Price DECIMAL(10,2) NOT NULL,
    Description NVARCHAR(500),
    ExpenseDate DATE DEFAULT GETDATE(),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Expenses_User FOREIGN KEY (UserId) REFERENCES Users(UserId),
    CONSTRAINT FK_Expenses_Payment FOREIGN KEY (PaymentId) REFERENCES PaymentMethods(PaymentId)
);
GO


-- Bildirimler tablosu
CREATE TABLE Notifications (
    NotId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    Title VARCHAR(255),
    Body NVARCHAR(max),
    IsRead BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Notification_User FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
GO


-- Tokenler tablosu
CREATE TABLE UserTokens (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    Token NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    CONSTRAINT FK_UserTokens_User FOREIGN KEY (UserId) REFERENCES Users(UserId)
); 
GO
