CREATE TABLE [dbo].[PersonSkill] (
  [PerSk_Id] [int] IDENTITY,
  [Person_Id] [int] NOT NULL,
  [Skill_Id] [int] NOT NULL,
  [Experience] [tinyint] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_PersonSkill_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_PersonSkill] PRIMARY KEY CLUSTERED ([PerSk_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_PersonSkill]
  ON [dbo].[PersonSkill] ([Person_Id], [Skill_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[PersonSkill]
  ADD CONSTRAINT [FK_PersonSkill_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[PersonSkill]
  ADD CONSTRAINT [FK_PersonSkill_Person] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO

ALTER TABLE [dbo].[PersonSkill]
  ADD CONSTRAINT [FK_PersonSkill_Skills] FOREIGN KEY ([Skill_Id]) REFERENCES [dbo].[Skills] ([Skill_Id])
GO