CREATE TABLE [dbo].[OrgServersHistory] (
  [Org_Id] [int] NULL,
  [Server_Id] [int] NULL,
  [Limit] [int] NULL,
  [Status] [int] NULL,
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Group_Id] [int] NULL
)
ON [PRIMARY]
GO