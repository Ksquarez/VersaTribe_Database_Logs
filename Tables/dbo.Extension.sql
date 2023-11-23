CREATE TABLE [dbo].[Extension] (
  [Ext_Id] [int] IDENTITY,
  [Ext_Num] [int] NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Extension_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Extension] PRIMARY KEY CLUSTERED ([Ext_Id])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Extension]
  ON [dbo].[Extension] ([Ext_Num])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create TRIGGER [dbo].[tr_ExtensionActivity]
ON [dbo].[Extension]
AFTER INSERT, UPDATE, DELETE AS
BEGIN
INSERT INTO ExtensionHistory
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[Extension]
  ADD CONSTRAINT [FK_Extension_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO