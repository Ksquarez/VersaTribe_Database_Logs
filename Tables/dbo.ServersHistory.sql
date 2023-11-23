CREATE TABLE [dbo].[ServersHistory] (
  [Server_Id] [int] NOT NULL,
  [Server_Name] [nvarchar](50) NOT NULL,
  [Status] [int] NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL
)
ON [PRIMARY]
GO