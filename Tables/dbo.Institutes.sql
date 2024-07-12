CREATE TABLE [dbo].[Institutes] (
  [Inst_Id] [int] IDENTITY,
  [Inst_Name] [nvarchar](50) NOT NULL,
  [Inst_Type] [nvarchar](50) NULL,
  [City] [nvarchar](50) NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [Status] [int] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_Institutes] PRIMARY KEY CLUSTERED ([Inst_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Institutes]
  ON [dbo].[Institutes] ([Inst_Name])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create TRIGGER [dbo].[tr_InstitutesActivity]
ON [dbo].[Institutes]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO InstitutesHistory
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[Institutes]
  ADD CONSTRAINT [FK_Institutes_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO