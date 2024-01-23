CREATE TABLE [dbo].[Experience] (
  [Exp_Id] [int] IDENTITY,
  [Company_Name] [nvarchar](50) NULL,
  [Industry_Field_Name] [nvarchar](50) NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF__Experienc__Statu__2DD1C37F] DEFAULT (0),
  CONSTRAINT [PK_Experience] PRIMARY KEY CLUSTERED ([Exp_Id]),
  CONSTRAINT [CK_Experience] CHECK ([Company_Name] IS NOT NULL AND [Industry_Field_Name] IS NULL OR [Company_Name] IS NULL AND [Industry_Field_Name] IS NOT NULL)
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Experience]
  ON [dbo].[Experience] ([Company_Name], [Industry_Field_Name])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Experience_1]
  ON [dbo].[Experience] ([Company_Name])
  ON [PRIMARY]
GO

CREATE INDEX [IX_Experience_2]
  ON [dbo].[Experience] ([Industry_Field_Name])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_ExperienceActivity]
ON [dbo].[Experience]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO [Histroy].[Experience]
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[Experience]
  ADD CONSTRAINT [FK_Experience_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO