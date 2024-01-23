CREATE TABLE [dbo].[Shift_Person] (
  [ShiftPer_Id] [int] IDENTITY,
  [Shift_Id] [int] NOT NULL,
  [Person_Id] [int] NOT NULL,
  [Status] [nchar](10) NOT NULL CONSTRAINT [DF_Shift_Person_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Shift_Person] PRIMARY KEY CLUSTERED ([ShiftPer_Id])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Shift_Person]
  ADD CONSTRAINT [FK_Shift_Person_Person] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO

ALTER TABLE [dbo].[Shift_Person]
  ADD CONSTRAINT [FK_Shift_Person_Shift] FOREIGN KEY ([Shift_Id]) REFERENCES [dbo].[Shift] ([Shift_Id])
GO