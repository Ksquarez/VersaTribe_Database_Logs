CREATE TABLE [dbo].[OrgRoles] (
  [Role_Id] [int] IDENTITY,
  [Org_Id] [int] NOT NULL,
  [Role_Name] [nvarchar](50) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_OrgRoles_Status] DEFAULT (0),
  CONSTRAINT [PK_OrgRoles] PRIMARY KEY CLUSTERED ([Role_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_OrgRoles]
  ON [dbo].[OrgRoles] ([Org_Id], [Role_Name])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrgRoles]
  ADD CONSTRAINT [FK_OrgRoles_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[OrgRoles]
  ADD CONSTRAINT [FK_OrgRoles_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO