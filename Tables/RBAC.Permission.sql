CREATE TABLE [RBAC].[Permission] (
  [PermissionID] [int] NOT NULL,
  [PermissionName] [varchar](255) NULL,
  [Operation] [varchar](50) NULL,
  PRIMARY KEY CLUSTERED ([PermissionID])
)
ON [PRIMARY]
GO