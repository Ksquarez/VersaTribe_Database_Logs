CREATE TABLE [dbo].[Servers] (
  [Srv_Id] [int] IDENTITY,
  [Name] [nvarchar](max) NULL,
  [IP_Address] [nvarchar](200) NOT NULL,
  [CreatedBy] [nvarchar](256) NULL,
  [CreatedOn] [datetime] NULL,
  [UpdatedBy] [nvarchar](256) NULL,
  [UpdatedOn] [datetime] NULL,
  [server_trunk_limit] [int] NULL,
  [Server_Domain] [nvarchar](max) NULL,
  [wss_port] [nvarchar](max) NULL,
  [server_id] [int] NULL,
  [Active] [bit] NULL,
  CONSTRAINT [PK_Servers] PRIMARY KEY CLUSTERED ([Srv_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO