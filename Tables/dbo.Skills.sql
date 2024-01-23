CREATE TABLE [dbo].[Skills] (
  [Skill_Id] [int] IDENTITY,
  [Skill_Field] [nvarchar](50) NULL,
  [Skill_Name] [nvarchar](50) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_Skills] PRIMARY KEY CLUSTERED ([Skill_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Skills]
  ON [dbo].[Skills] ([Skill_Name])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_SkillsActivity]
ON [dbo].[Skills]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO [Histroy].[Skills]
SELECT * FROM INSERTED
END
GO



SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO