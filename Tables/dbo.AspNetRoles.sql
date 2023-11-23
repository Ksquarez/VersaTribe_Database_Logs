CREATE TABLE [dbo].[AspNetRoles] (
  [Id] [nvarchar](128) NOT NULL,
  [Name] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [RoleNameIndex]
  ON [dbo].[AspNetRoles] ([Name])
  ON [PRIMARY]
GO