CREATE TABLE [dbo].[PersonSkillHistory] (
  [PerSk_Id] [int] NOT NULL,
  [Person_Id] [int] NOT NULL,
  [Skill_Id] [int] NOT NULL,
  [Experience] [tinyint] NULL,
  [Status] [int] NULL,
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL
)
ON [PRIMARY]
GO