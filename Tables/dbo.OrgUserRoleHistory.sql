CREATE TABLE [dbo].[OrgUserRoleHistory] (
  [Role_Id] [int] NOT NULL,
  [Person_Id] [int] NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL,
  [IsCaller] [bit] NULL,
  [Ext_Id] [int] NULL
)
ON [PRIMARY]
GO