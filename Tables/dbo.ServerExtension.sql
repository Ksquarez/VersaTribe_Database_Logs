CREATE TABLE [dbo].[ServerExtension] (
  [Server_Id] [int] NOT NULL,
  [Ext_Id] [int] NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_ServerExtension_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_ServerExtension]
  ON [dbo].[ServerExtension] ([Server_Id], [Ext_Id])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create TRIGGER [dbo].[tr_ServerExtensionActivity]
ON [dbo].[ServerExtension]
AFTER INSERT, UPDATE, DELETE AS
BEGIN
INSERT INTO ServerExtensionHistory
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[ServerExtension]
  ADD CONSTRAINT [FK_ServerExtension_Extension] FOREIGN KEY ([Ext_Id]) REFERENCES [dbo].[Extension] ([Ext_Id])
GO

ALTER TABLE [dbo].[ServerExtension]
  ADD CONSTRAINT [FK_ServerExtension_Servers] FOREIGN KEY ([Server_Id]) REFERENCES [dbo].[Servers] ([Server_Id])
GO