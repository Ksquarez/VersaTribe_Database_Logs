CREATE TABLE [dbo].[PersonHistory] (
  [Person_Id] [int] NOT NULL,
  [FirstName] [nvarchar](50) NOT NULL,
  [LastName] [nvarchar](50) NOT NULL,
  [Gender] [nvarchar](50) NULL,
  [City] [nvarchar](50) NOT NULL,
  [Country] [nvarchar](50) NOT NULL,
  [DOJ] [datetime2] NULL,
  [DOB] [date] NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL DEFAULT (0)
)
ON [PRIMARY]
GO