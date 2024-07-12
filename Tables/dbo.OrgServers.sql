CREATE TABLE [dbo].[OrgServers] (
  [Org_Id] [int] NOT NULL,
  [Server_Id] [int] NOT NULL,
  [Limit] [int] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_OrgServers_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Group_Id] [int] NULL,
  [Is_Prime] [bit] NULL,
  CONSTRAINT [PK_OrgServers] PRIMARY KEY CLUSTERED ([Org_Id], [Server_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UK_OrgServers_Org_Id]
  ON [dbo].[OrgServers] ([Org_Id])
  ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UK_OrgServers_Server_Id]
  ON [dbo].[OrgServers] ([Server_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrgServers]
  ADD CONSTRAINT [FK_OrgServers_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[OrgServers]
  ADD CONSTRAINT [FK_OrgServers_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO

ALTER TABLE [dbo].[OrgServers]
  ADD CONSTRAINT [FK_OrgServers_Servers] FOREIGN KEY ([Server_Id]) REFERENCES [dbo].[Servers] ([Srv_Id])
GO