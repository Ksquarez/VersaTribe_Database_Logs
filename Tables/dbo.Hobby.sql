﻿CREATE TABLE [dbo].[Hobby] (
  [Hobby_Id] [int] IDENTITY,
  [Name] [nvarchar](50) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_Hobby] PRIMARY KEY CLUSTERED ([Hobby_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Hobby]
  ON [dbo].[Hobby] ([Name])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Hobby]
  ADD CONSTRAINT [FK_Hobby_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO