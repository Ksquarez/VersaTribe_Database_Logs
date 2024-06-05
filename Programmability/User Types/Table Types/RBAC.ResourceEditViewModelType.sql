CREATE TYPE [RBAC].[ResourceEditViewModelType] AS TABLE (
  [RoleID] [int] NULL,
  [ResourceID] [int] NULL,
  [PermissionID] [int] NULL,
  [Allowed] [bit] NULL
)
GO