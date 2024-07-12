CREATE TABLE [Recruitment].[Candidate_Skills] (
  [Candidate_Skills_Id] [int] IDENTITY,
  [Candidate_Id] [int] NULL,
  [Skill_Id] [int] NULL,
  [Experience] [tinyint] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Candidate_Skills_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Candidate_Skills] PRIMARY KEY CLUSTERED ([Candidate_Skills_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Candidate_Skills]
  ON [Recruitment].[Candidate_Skills] ([Candidate_Id], [Skill_Id])
  ON [PRIMARY]
GO

ALTER TABLE [Recruitment].[Candidate_Skills]
  ADD CONSTRAINT [FK_Candidate_Skills_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [Recruitment].[Candidate_Skills]
  ADD CONSTRAINT [FK_Candidate_Skills_Skills] FOREIGN KEY ([Skill_Id]) REFERENCES [dbo].[Skills] ([Skill_Id])
GO