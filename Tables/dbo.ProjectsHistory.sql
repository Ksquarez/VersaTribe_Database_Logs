CREATE TABLE [dbo].[ProjectsHistory] (
  [Project_Id] [int] NOT NULL,
  [Project_Name] [nvarchar](50) NOT NULL,
  [Person_Id] [int] NOT NULL,
  [Status] [int] NOT NULL,
  [Start_Date] [date] NULL,
  [End_Date] [date] NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Org_Id] [int] NOT NULL,
  [Progress] [int] NULL
)
ON [PRIMARY]
GO