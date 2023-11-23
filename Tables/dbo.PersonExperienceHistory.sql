CREATE TABLE [dbo].[PersonExperienceHistory] (
  [PerExp_Id] [int] NOT NULL,
  [Person_Id] [int] NOT NULL,
  [Exp_Id] [int] NOT NULL,
  [Exp_months] [int] NOT NULL,
  [Job_Title] [nvarchar](50) NOT NULL,
  [Status] [int] NOT NULL,
  [Start_date] [date] NULL,
  [End_Date] [date] NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL
)
ON [PRIMARY]
GO