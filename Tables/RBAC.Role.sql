CREATE TABLE [RBAC].[Role] (
  [RoleID] [int] IDENTITY,
  [Name] [varchar](100) NULL,
  [Description] [varchar](255) NULL,
  [Org_Id] [int] NULL,
  PRIMARY KEY CLUSTERED ([RoleID])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UK_Role]
  ON [RBAC].[Role] ([Name], [Org_Id])
  ON [PRIMARY]
GO

ALTER TABLE [RBAC].[Role]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id]) ON DELETE CASCADE
GO