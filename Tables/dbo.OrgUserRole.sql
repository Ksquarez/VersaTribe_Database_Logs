CREATE TABLE [dbo].[OrgUserRole] (
  [Role_Id] [int] NOT NULL,
  [Person_Id] [int] NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_OrgUserRole_Status] DEFAULT (0),
  [IsCaller] [bit] NULL,
  [Ext_Id] [int] NULL,
  CONSTRAINT [PK_OrgUserRole] PRIMARY KEY CLUSTERED ([Role_Id], [Person_Id])
)
ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create TRIGGER [dbo].[tr_OrgUserRoleActivity]
ON [dbo].[OrgUserRole]
AFTER INSERT, UPDATE, DELETE AS
BEGIN
INSERT INTO OrgUserRoleHistory
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[OrgUserRole]
  ADD CONSTRAINT [FK_OrgUserRole_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[OrgUserRole]
  ADD CONSTRAINT [FK_OrgUserRole_OrgRoles1] FOREIGN KEY ([Role_Id]) REFERENCES [dbo].[OrgRoles] ([Role_Id])
GO

ALTER TABLE [dbo].[OrgUserRole]
  ADD CONSTRAINT [FK_OrgUserRole_Person] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO