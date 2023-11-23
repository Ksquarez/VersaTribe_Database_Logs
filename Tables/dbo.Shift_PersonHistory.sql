CREATE TABLE [dbo].[Shift_PersonHistory] (
  [ShiftPer_Id] [int] NOT NULL,
  [Shift_Id] [int] NOT NULL,
  [Person_Id] [int] NOT NULL,
  [Status] [nchar](10) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL
)
ON [PRIMARY]
GO