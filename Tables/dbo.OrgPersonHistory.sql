CREATE TABLE [dbo].[OrgPersonHistory] (
  [Person_Id] [int] NOT NULL,
  [Org_Id] [int] NOT NULL,
  [Dept_Id] [int] NULL,
  [Status] [int] NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Request_Status] [int] NOT NULL,
  [Dept_Req] [nvarchar](50) NULL,
  [IsCaller] [bit] NULL,
  [Extension_Id] [bigint] NULL,
  [Server_Id] [int] NULL
)
ON [PRIMARY]
GO