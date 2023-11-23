CREATE TABLE [dbo].[Org] (
  [Org_Id] [int] IDENTITY,
  [Org_Name] [nvarchar](50) NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Org_Status] DEFAULT (0),
  [OrgAdmin_Id] [nvarchar](256) NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Org] PRIMARY KEY CLUSTERED ([Org_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Org]
  ON [dbo].[Org] ([Org_Name])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create TRIGGER [dbo].[tr_OrgActivity]
ON [dbo].[Org]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO OrgHistory
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[Org]
  ADD CONSTRAINT [FK_Org_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO