CREATE TABLE [dbo].[Project_UserHistory] (
  [Id] [int] NOT NULL,
  [Person_Id] [int] NOT NULL,
  [Project_Id] [int] NOT NULL,
  [Status] [int] NOT NULL,
  [Role] [nvarchar](50) NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [IsApproved] [bit] NULL
)
ON [PRIMARY]
GO