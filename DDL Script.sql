CREATE DATABASE [Farms];
GO

USE [Farms];
GO

CREATE TABLE [Owner]
(
  [CVR] INT NOT NULL,
  [First] VARCHAR(32) NOT NULL,
  [Last] VARCHAR(32) NOT NULL,
  [Streetname] VARCHAR(64) NOT NULL,
  [No] INT NOT NULL,
  [Postcode] INT NOT NULL,
  [City] VARCHAR(32) NOT NULL,
  [Email] VARCHAR(64) NOT NULL,
  PRIMARY KEY ([CVR])
);
GO

CREATE TABLE [Farm]
(
  [Pnumber] INT NOT NULL,
  [Name] VARCHAR(32) NOT NULL,
  [Streetname] VARCHAR(64) NOT NULL,
  [No] INT NOT NULL,
  [Postcode] INT NOT NULL,
  [City] VARCHAR(32) NOT NULL,
  [CVR] INT NOT NULL,
  PRIMARY KEY ([Pnumber]),
  FOREIGN KEY ([CVR]) REFERENCES [Owner]([CVR])
);
GO

CREATE TABLE [Stall]
(
  [No] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  PRIMARY KEY ([No], [Pnumber]),
  CONSTRAINT FOREIGN KEY ([Pnumber]) REFERENCES [Farm]([Pnumber])
);
GO

CREATE TABLE [Box]
(
  [Type] VARCHAR(32) NOT NULL,
  [Outdoor] BIT NOT NULL,
  [No] INT NOT NULL,
  [Stall_No] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  PRIMARY KEY ([No], [Stall_No], [Pnumber]),
  CONSTRAINT FOREIGN KEY ([Stall_No], [Pnumber]) REFERENCES [Stall]([No], [Pnumber])
);
GO

CREATE TABLE [SmartUnit]
(
  [Type] VARCHAR(32) NOT NULL,
  [Serialnumber] INT NOT NULL,
  [IpAddress] VARCHAR(32) NOT NULL,
  [MacAddress] VARCHAR(32) NOT NULL,
  PRIMARY KEY ([Serialnumber])
);
GO

CREATE TABLE [State]
(
  [Severity] INT NOT NULL,
  [Id] INT NOT NULL,
  PRIMARY KEY ([Id])
);
GO

CREATE TABLE [box_monitor]
(
  [Value] INT NOT NULL,
  [Time] DATETIME NOT NULL,
  [No] INT NOT NULL,
  [Stall_No] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  [Serialnumber] INT NOT NULL,
  PRIMARY KEY ([No], [Stall_No], [Pnumber], [Serialnumber]),
  CONSTRAINT FOREIGN KEY ([No], [Stall_No], [Pnumber]) REFERENCES [Box]([No], [Stall_No], [Pnumber]),
  CONSTRAINT FOREIGN KEY ([Serialnumber]) REFERENCES [SmartUnit]([Serialnumber])
);
GO

CREATE TABLE [stall_monitor]
(
  [No] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  [Serialnumber] INT NOT NULL,
  PRIMARY KEY ([No], [Pnumber], [Serialnumber]),
  CONSTRAINT FOREIGN KEY ([No], [Pnumber]) REFERENCES [Stall]([No], [Pnumber]),
  CONSTRAINT FOREIGN KEY ([Serialnumber]) REFERENCES [SmartUnit]([Serialnumber])
);
GO

CREATE TABLE [changes]
(
  [Time] DATETIME NOT NULL,
  [Serialnumber] INT NOT NULL,
  [Id] INT NOT NULL,
  PRIMARY KEY ([Serialnumber], [Id]),
  CONSTRAINT FOREIGN KEY ([Serialnumber]) REFERENCES [SmartUnit]([Serialnumber]),
  CONSTRAINT FOREIGN KEY ([Id]) REFERENCES [State]([Id])
);
GO

CREATE TABLE [Owner_Phone]
(
  [Phone] VARCHAR(16) NOT NULL,
  [CVR] INT NOT NULL,
  PRIMARY KEY ([Phone], [CVR]),
  CONSTRAINT FOREIGN KEY ([CVR]) REFERENCES [Owner]([CVR])
);
GO

CREATE TABLE [Farm_ChrNo]
(
  [ChrNo] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  PRIMARY KEY ([ChrNo], [Pnumber]),
  CONSTRAINT FOREIGN KEY ([Pnumber]) REFERENCES [Farm]([Pnumber])
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
  [Age] SQL_VARIANT DEFAULT (DATEDIFF(year, [Birth], getdate())),
  [produce_ChrNo] INT,
  [produce_Color] VARCHAR(16),
  [produce_Id] INT,
  PRIMARY KEY ([ChrNo], [Color], [Id]),
  CONSTRAINT FOREIGN KEY ([produce_ChrNo], [produce_Color], [produce_Id]) REFERENCES [Animal]([ChrNo], [Color], [Id])
);
GO

CREATE TABLE [lives_in]
(
  [MoveInTime] DATETIME NOT NULL,
  [MoveOutTime] DATETIME NULL,
  [No] INT NOT NULL,
  [Stall_No] INT NOT NULL,
  [Pnumber] INT NOT NULL,
  [ChrNo] INT NOT NULL,
  [Color] VARCHAR(16) NOT NULL,
  [Id] INT NOT NULL,
  PRIMARY KEY ([No], [Stall_No], [Pnumber], [ChrNo], [Color], [Id]),
  CONSTRAINT FOREIGN KEY ([No], [Stall_No], [Pnumber]) REFERENCES [Box]([No], [Stall_No], [Pnumber]),
  CONSTRAINT FOREIGN KEY ([ChrNo], [Color], [Id]) REFERENCES [Animal]([ChrNo], [Color], [Id])
);
GO