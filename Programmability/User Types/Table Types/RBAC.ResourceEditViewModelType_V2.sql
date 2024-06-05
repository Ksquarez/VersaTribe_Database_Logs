CREATE TYPE [RBAC].[ResourceEditViewModelType_V2] AS TABLE (
  [RoleID] [int] NULL,
  [ResourceID] [int] NULL,
  [Allowed] [bit] NULL
)
GO