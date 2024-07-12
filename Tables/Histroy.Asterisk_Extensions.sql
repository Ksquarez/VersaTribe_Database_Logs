CREATE TABLE [Histroy].[Asterisk_Extensions] (
  [Extension_Id] [int] NULL,
  [Org_Id] [int] NULL,
  [Person_Id] [int] NULL,
  [Extension_Srv_Id] [nvarchar](max) NULL,
  [Srv_Id] [int] NULL,
  [UserName] [nvarchar](max) NULL,
  [Secret] [nvarchar](max) NULL,
  [Transport] [nvarchar](max) NULL,
  [TStamp] [datetime] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Status] [int] NULL,
  [Active] [bit] NULL,
  [context_Id] [int] NULL,
  [DateOrder] [datetime] NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO