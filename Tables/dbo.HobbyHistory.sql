CREATE TABLE [dbo].[HobbyHistory] (
  [Hobby_Id] [int] NOT NULL,
  [Name] [nvarchar](50) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL DEFAULT (0)
)
ON [PRIMARY]
GO