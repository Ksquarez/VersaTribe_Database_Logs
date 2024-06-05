CREATE TABLE [RBAC].[ResourcePermission_V2] (
  [RoleID] [int] NOT NULL,
  [ResourceID] [int] NOT NULL,
  [Allowed] [bit] NULL,
  PRIMARY KEY CLUSTERED ([RoleID], [ResourceID])
)
ON [PRIMARY]
GO

ALTER TABLE [RBAC].[ResourcePermission_V2]
  ADD FOREIGN KEY ([ResourceID]) REFERENCES [RBAC].[Resource_V2] ([ResourceID])
GO

ALTER TABLE [RBAC].[ResourcePermission_V2]
  ADD FOREIGN KEY ([RoleID]) REFERENCES [RBAC].[Role] ([RoleID])
GO