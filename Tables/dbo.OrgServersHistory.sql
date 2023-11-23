CREATE TABLE [dbo].[OrgServersHistory] (
  [Org_Id] [int] NOT NULL,
  [Server_Id] [int] NOT NULL,
  [Limit] [int] NULL,
  [Status] [int] NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Gr_Id] [int] NULL
)
ON [PRIMARY]
GO