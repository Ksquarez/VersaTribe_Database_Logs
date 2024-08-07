﻿CREATE TABLE [dbo].[Person] (
  [Person_Id] [int] IDENTITY,
  [FirstName] [nvarchar](50) NULL,
  [LastName] [nvarchar](50) NULL,
  [Gender] [nvarchar](50) NULL,
  [City] [nvarchar](50) NULL,
  [Country] [nvarchar](50) NULL,
  [DOJ] [datetime2] NULL,
  [DOB] [date] NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF__Person__Status__40058253] DEFAULT (0),
  [Profile_Pic_Path] [nvarchar](max) NULL,
  CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED ([Person_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE UNIQUE INDEX [TOwner]
  ON [dbo].[Person] ([TOwner])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_PersonActivity]
ON [dbo].[Person]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO [Histroy].[Person]
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[Person]
  ADD CONSTRAINT [FK_Person_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO