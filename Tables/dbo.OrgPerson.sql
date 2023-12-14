CREATE TABLE [dbo].[OrgPerson] (
  [Person_Id] [int] NOT NULL,
  [Org_Id] [int] NOT NULL,
  [Dept_Id] [int] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_OrgPerson_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Request_Status] [int] NULL,
  [Dept_Req] [nvarchar](50) NULL,
  [IsCaller] [bit] NULL,
  [Extension_Id] [bigint] NULL,
  [Server_Id] [int] NULL,
  [Is_Default] [bit] NULL,
  CONSTRAINT [PK_OrgPerson_1] PRIMARY KEY CLUSTERED ([Person_Id], [Org_Id])
)
ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create TRIGGER [dbo].[tr_OrgPersonActivity]
ON [dbo].[OrgPerson]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO OrgPersonHistory
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[OrgPerson]
  ADD CONSTRAINT [FK_OrgPerson_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[OrgPerson]
  ADD CONSTRAINT [FK_OrgPerson_Department] FOREIGN KEY ([Dept_Id]) REFERENCES [dbo].[Department] ([Dept_Id])
GO

ALTER TABLE [dbo].[OrgPerson]
  ADD CONSTRAINT [FK_OrgPerson_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO

ALTER TABLE [dbo].[OrgPerson]
  ADD CONSTRAINT [FK_OrgPerson_Person] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO