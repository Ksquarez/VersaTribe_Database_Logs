CREATE TABLE [dbo].[OrgPersonHistory] (
  [Person_Id] [int] NULL,
  [Org_Id] [int] NULL,
  [Dept_Id] [int] NULL,
  [Status] [int] NULL,
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Request_Status] [int] NULL,
  [Dept_Req] [nvarchar](50) NULL,
  [IsCaller] [bit] NULL,
  [Extension_Id] [bigint] NULL,
  [Server_Id] [int] NULL,
  [Is_Default] [int] NULL
)
ON [PRIMARY]
GO