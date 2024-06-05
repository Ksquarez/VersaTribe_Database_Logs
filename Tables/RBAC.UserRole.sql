CREATE TABLE [RBAC].[UserRole] (
  [UserRoleId] [int] IDENTITY,
  [Person_Id] [int] NULL,
  [RoleID] [int] NULL,
  [Org_Id] [int] NULL,
  PRIMARY KEY CLUSTERED ([UserRoleId])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UK_UserRole]
  ON [RBAC].[UserRole] ([Person_Id], [RoleID], [Org_Id])
  ON [PRIMARY]
GO

ALTER TABLE [RBAC].[UserRole]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id]) ON DELETE CASCADE
GO

ALTER TABLE [RBAC].[UserRole]
  ADD CONSTRAINT [FK__UserRole__Person__4F87BD05] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO

ALTER TABLE [RBAC].[UserRole]
  ADD FOREIGN KEY ([RoleID]) REFERENCES [RBAC].[Role] ([RoleID])
GO