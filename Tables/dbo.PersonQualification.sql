﻿CREATE TABLE [dbo].[PersonQualification] (
  [PQ_Id] [int] IDENTITY,
  [QI_Id] [int] NOT NULL,
  [Person_Id] [int] NOT NULL,
  [YOP] [date] NULL,
  [Grade] [varchar](5) NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_PersonQualification_Status] DEFAULT (0),
  [TOwner] [nvarchar](256) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [City] [nvarchar](50) NULL,
  CONSTRAINT [PK_PersonQualification] PRIMARY KEY CLUSTERED ([PQ_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_PersonQualification]
  ON [dbo].[PersonQualification] ([QI_Id], [Person_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[PersonQualification]
  ADD CONSTRAINT [FK_PersonQualification_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[PersonQualification]
  ADD CONSTRAINT [FK_PersonQualification_Person] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO

ALTER TABLE [dbo].[PersonQualification]
  ADD CONSTRAINT [FK_PersonQualification_Qualification] FOREIGN KEY ([QI_Id]) REFERENCES [dbo].[Qualification] ([QI_Id])
GO