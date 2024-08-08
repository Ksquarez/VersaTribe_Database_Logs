CREATE TABLE [dbo].[trunk] (
  [Id] [int] IDENTITY,
  [context_Id] [int] NULL,
  [trunk_name] [nvarchar](20) NULL,
  [trunk_server_ip] [nvarchar](max) NULL,
  [trunk_server_port] [nvarchar](50) NULL,
  [trunk_authentication] [bit] NULL,
  [trunk_password] [nvarchar](max) NULL,
  [trunk_username] [nvarchar](max) NULL,
  [Status] [int] NULL,
  [TOwner] [nvarchar](max) NULL,
  [TStamp] [datetime] NULL,
  [Org_Id] [int] NULL,
  [Active] [bit] NULL,
  [server_id] [int] NULL,
  CONSTRAINT [PK_trunk_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UK_trunk_trunk_name]
  ON [dbo].[trunk] ([trunk_name])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[trunk]
  ADD FOREIGN KEY ([context_Id]) REFERENCES [dbo].[context] ([Id])
GO

ALTER TABLE [dbo].[trunk]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO