CREATE TABLE [dbo].[Servers] (
  [Server_Id] [int] IDENTITY,
  [Server_Name] [nvarchar](50) NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Servers_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Servers] PRIMARY KEY CLUSTERED ([Server_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Servers]
  ON [dbo].[Servers] ([Server_Name])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create TRIGGER [dbo].[tr_ServersActivity]
ON [dbo].[Servers]
AFTER INSERT, UPDATE, DELETE AS
BEGIN
INSERT INTO ServersHistory
SELECT * FROM INSERTED
END
GO