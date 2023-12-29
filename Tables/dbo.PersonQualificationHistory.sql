CREATE TABLE [dbo].[PersonQualificationHistory] (
  [PQ_Id] [int] NOT NULL,
  [QI_Id] [int] NOT NULL,
  [Person_Id] [int] NOT NULL,
  [YOP] [date] NULL,
  [Grade] [varchar](5) NULL,
  [Status] [int] NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [City] [nvarchar](50) NULL
)
ON [PRIMARY]
GO