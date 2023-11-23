CREATE TABLE [dbo].[PersonHobbyHistory] (
  [Person_Id] [int] NOT NULL,
  [Hobby_Id] [int] NOT NULL,
  [Status] [int] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [TStamp] [datetime2] NOT NULL
)
ON [PRIMARY]
GO