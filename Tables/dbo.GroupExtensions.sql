CREATE TABLE [dbo].[GroupExtensions] (
  [Grp_Ext_Id] [int] IDENTITY,
  [Extension_Id] [int] NULL,
  [Srv_Group_Id] [int] NULL,
  [Group_Id] [int] NULL,
  CONSTRAINT [PK_GroupExtensions_Id] PRIMARY KEY CLUSTERED ([Grp_Ext_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_GroupExtensions]
  ON [dbo].[GroupExtensions] ([Extension_Id], [Group_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[GroupExtensions]
  ADD FOREIGN KEY ([Group_Id]) REFERENCES [dbo].[Groups] ([Group_Id])
GO

ALTER TABLE [dbo].[GroupExtensions]
  ADD CONSTRAINT [FK_GroupExtensions_Extensions] FOREIGN KEY ([Extension_Id]) REFERENCES [dbo].[Extensions] ([Extension_Id])
GO

ALTER TABLE [dbo].[GroupExtensions]
  ADD CONSTRAINT [FK_GroupExtensions_ServerGroups] FOREIGN KEY ([Srv_Group_Id]) REFERENCES [dbo].[ServerGroups] ([Srv_Group_Id])
GO