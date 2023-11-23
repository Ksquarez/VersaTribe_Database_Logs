CREATE TABLE [dbo].[OrgServers] (
  [Org_Id] [int] NOT NULL,
  [Server_Id] [int] NOT NULL,
  [Limit] [int] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_OrgServers_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Gr_Id] [int] NULL,
  CONSTRAINT [PK_OrgServers] PRIMARY KEY CLUSTERED ([Org_Id], [Server_Id])
)
ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create TRIGGER [dbo].[tr_OrgServersActivity]
ON [dbo].[OrgServers]
AFTER INSERT, UPDATE, DELETE AS
BEGIN
INSERT INTO OrgServersHistory
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[OrgServers]
  ADD CONSTRAINT [FK_OrgServers_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[OrgServers]
  ADD CONSTRAINT [FK_OrgServers_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO