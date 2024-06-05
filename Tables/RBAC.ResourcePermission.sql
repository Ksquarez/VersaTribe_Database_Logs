CREATE TABLE [RBAC].[ResourcePermission] (
  [RoleID] [int] NOT NULL,
  [ResourceID] [int] NOT NULL,
  [Allowed] [bit] NULL,
  [PermissionID] [int] NOT NULL,
  PRIMARY KEY CLUSTERED ([RoleID], [ResourceID], [PermissionID])
)
ON [PRIMARY]
GO

ALTER TABLE [RBAC].[ResourcePermission]
  ADD FOREIGN KEY ([PermissionID]) REFERENCES [RBAC].[Permission] ([PermissionID])
GO

ALTER TABLE [RBAC].[ResourcePermission]
  ADD FOREIGN KEY ([ResourceID]) REFERENCES [RBAC].[Resource] ([ResourceID])
GO

ALTER TABLE [RBAC].[ResourcePermission]
  ADD FOREIGN KEY ([RoleID]) REFERENCES [RBAC].[Role] ([RoleID])
GO