CREATE TABLE [dbo].[Skills_Criteria] (
  [Training_Id] [int] NOT NULL,
  [Skill_Id] [int] NOT NULL,
  [Experience] [tinyint] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Skills_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Mandatory] [bit] NULL,
  [Id] [int] IDENTITY,
  CONSTRAINT [PK_Skills_Criteria] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Skills_Criteria]
  ON [dbo].[Skills_Criteria] ([Training_Id], [Skill_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Skills_Criteria]
  ADD CONSTRAINT [FK_Skills_Criteria_Skills] FOREIGN KEY ([Skill_Id]) REFERENCES [dbo].[Skills] ([Skill_Id])
GO