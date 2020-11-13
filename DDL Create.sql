CREATE DATABASE [Farms];
GO

USE [Farms];
GO

CREATE TABLE [Owner]
(
  [CVR] INT NOT NULL,
  [FirstName] VARCHAR(32) NOT NULL,
  [LastName] VARCHAR(32) NOT NULL,
  [Streetname] VARCHAR(64) NOT NULL,
  [No] INT NOT NULL,
  [Postcode] INT NOT NULL,
  [City] VARCHAR(32) NOT NULL,
  [Email] VARCHAR(64) NOT NULL,
  CONSTRAINT PK_Owner PRIMARY KEY ([CVR])
);
GO

CREATE TABLE [Farm]
(
  [Pnumber] BIGINT NOT NULL,
  [Name] VARCHAR(32) NOT NULL,
  [Streetname] VARCHAR(64) NOT NULL,
  [No] INT NOT NULL,
  [Postcode] INT NOT NULL,
  [City] VARCHAR(32) NOT NULL,
  [CVR] INT NOT NULL,
  CONSTRAINT PK_Farm PRIMARY KEY ([Pnumber]),
  CONSTRAINT FK_Owner_Farm FOREIGN KEY ([CVR]) REFERENCES [Owner]([CVR])
);
GO

CREATE TABLE [Stall]
(
  [No] INT NOT NULL,
  [Pnumber] BIGINT NOT NULL,
  CONSTRAINT PK_Stall PRIMARY KEY ([No], [Pnumber]),
  CONSTRAINT FK_Farm_Stall FOREIGN KEY ([Pnumber]) REFERENCES [Farm]([Pnumber])
);
GO

CREATE TABLE [Box]
(
  [Type] VARCHAR(32) NOT NULL,
  [Outdoor] BIT NOT NULL,
  [No] INT NOT NULL,
  [Stall_No] INT NOT NULL,
  [Pnumber] BIGINT NOT NULL,
  CONSTRAINT PK_Box PRIMARY KEY ([No], [Stall_No], [Pnumber]),
  CONSTRAINT FK_Stall_Box FOREIGN KEY ([Stall_No], [Pnumber]) REFERENCES [Stall]([No], [Pnumber])
);
GO

CREATE TABLE [SmartUnit]
(
  [Type] VARCHAR(32) NOT NULL,
  [SerialNumber] BIGINT NOT NULL,
  [IpAddress] VARCHAR(32) NOT NULL,
  [MacAddress] VARCHAR(32) NOT NULL,
  CONSTRAINT PK_SmartUnit PRIMARY KEY ([SerialNumber])
);
GO

CREATE TABLE [State]
(
  [Severity] INT NOT NULL,
  [Id] INT NOT NULL,
  CONSTRAINT PK_State PRIMARY KEY ([Id])
);
GO

CREATE TABLE [BoxMonitor]
(
  [Value] INT NOT NULL,
  [Time] DATETIME NOT NULL,
  [Box_No] INT NOT NULL,
  [Stall_No] INT NOT NULL,
  [Pnumber] BIGINT NOT NULL,
  [SerialNumber] BIGINT NOT NULL,
  CONSTRAINT PK_BoxMonitor PRIMARY KEY ([Box_No], [Stall_No], [Pnumber], [SerialNumber]),
  CONSTRAINT FK_Box_BoxMonitor FOREIGN KEY ([Box_No], [Stall_No], [Pnumber]) REFERENCES [Box]([No], [Stall_No], [Pnumber]),
  CONSTRAINT FK_SmartUnit_BoxMonitor FOREIGN KEY ([SerialNumber]) REFERENCES [SmartUnit]([SerialNumber])
);
GO

CREATE TABLE [StallMonitor]
(
  [Stall_No] INT NOT NULL,
  [Pnumber] BIGINT NOT NULL,
  [SerialNumber] BIGINT NOT NULL,
  CONSTRAINT PK_StallMonitor PRIMARY KEY ([Stall_No], [Pnumber], [SerialNumber]),
  CONSTRAINT FK_Stall_StallMonitor FOREIGN KEY ([Stall_No], [Pnumber]) REFERENCES [Stall]([No], [Pnumber]),
  CONSTRAINT FK_SmartUnit_StallMonitor FOREIGN KEY ([SerialNumber]) REFERENCES [SmartUnit]([SerialNumber])
);
GO

CREATE TABLE [Changes]
(
  [Time] DATETIME NOT NULL,
  [SerialNumber] BIGINT NOT NULL,
  [State_Id] INT NOT NULL,
  CONSTRAINT PK_Change PRIMARY KEY ([SerialNumber], [State_Id]),
  CONSTRAINT FK_SmartUnit_Changes FOREIGN KEY ([SerialNumber]) REFERENCES [SmartUnit]([SerialNumber]),
  CONSTRAINT FK_State_Changes FOREIGN KEY ([State_Id]) REFERENCES [State]([Id])
);
GO

CREATE TABLE [OwnerPhone]
(
  [Phone] VARCHAR(16) NOT NULL,
  [CVR] INT NOT NULL,
  CONSTRAINT PK_OwnerPhone PRIMARY KEY ([Phone], [CVR]),
  CONSTRAINT FK_Owner_OwnerPhone FOREIGN KEY ([CVR]) REFERENCES [Owner]([CVR])
);
GO

CREATE TABLE [FarmChrNo]
(
  [ChrNo] INT NOT NULL,
  [Pnumber] BIGINT NOT NULL,
  CONSTRAINT PK_FarmChrNo PRIMARY KEY ([ChrNo], [Pnumber]),
  CONSTRAINT FK_Farm_FarmChrNo FOREIGN KEY ([Pnumber]) REFERENCES [Farm]([Pnumber])
);
GO

CREATE TABLE [Animal]
(
  [ChrNo] INT NOT NULL,
  [Color] VARCHAR(16) NOT NULL,
  [Id] INT NOT NULL,
  [Sex] BIT NOT NULL,
  [Type] VARCHAR(16) NOT NULL,
  [Birth] DATE NOT NULL,
  [Death] DATE NULL,
  [Produce_ChrNo] INT,
  [Produce_Color] VARCHAR(16),
  [Produce_Id] INT,
  CONSTRAINT PK_Animal PRIMARY KEY ([ChrNo], [Color], [Id]),
  CONSTRAINT FK_Animal_Animal FOREIGN KEY ([produce_ChrNo], [produce_Color], [produce_Id]) REFERENCES [Animal]([ChrNo], [Color], [Id])
);
GO

ALTER TABLE [Animal] ADD [Age] AS (DATEDIFF(YEAR, [Birth], GETDATE()));
GO

CREATE TABLE [LivesIn]
(
  [MoveInTime] DATETIME NOT NULL,
  [MoveOutTime] DATETIME NULL,
  [Box_No] INT NOT NULL,
  [Stall_No] INT NOT NULL,
  [Pnumber] BIGINT NOT NULL,
  [ChrNo] INT NOT NULL,
  [Color] VARCHAR(16) NOT NULL,
  [Id] INT NOT NULL,
  CONSTRAINT PK_LivesIn PRIMARY KEY ([Box_No], [Stall_No], [Pnumber], [ChrNo], [Color], [Id]),
  CONSTRAINT FK_Box_LivesIn FOREIGN KEY ([Box_No], [Stall_No], [Pnumber]) REFERENCES [Box]([No], [Stall_No], [Pnumber]),
  CONSTRAINT FK_Animal_LivesIn FOREIGN KEY ([ChrNo], [Color], [Id]) REFERENCES [Animal]([ChrNo], [Color], [Id])
);
GO