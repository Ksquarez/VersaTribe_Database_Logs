CREATE TABLE [dbo].[SkillsHistory] (
  [Skill_Id] [int] NOT NULL,
  [Skill_Field] [nvarchar](50) NULL,
  [Skill_Name] [nvarchar](50) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL DEFAULT (0)
)
ON [PRIMARY]
GO