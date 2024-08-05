CREATE TABLE [Recruitment].[Candidate_Experience] (
  [Candidate_Experience_Id] [int] IDENTITY,
  [Candidate_Id] [int] NULL,
  [Exp_Id] [int] NULL,
  [Exp_Months] [int] NULL,
  [Job_Title] [nvarchar](50) NULL,
  [Start_Date] [date] NULL,
  [End_Date] [date] NULL,
  [Status] [int] NULL CONSTRAINT [DF_Candidate_Experience_Status] DEFAULT (0),
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  CONSTRAINT [PK_Candidate_Experience] PRIMARY KEY CLUSTERED ([Candidate_Experience_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Candidate_Experience]
  ON [Recruitment].[Candidate_Experience] ([Candidate_Id], [Exp_Id])
  ON [PRIMARY]
GO

ALTER TABLE [Recruitment].[Candidate_Experience]
  ADD CONSTRAINT [FK_Candidate_Experience_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [Recruitment].[Candidate_Experience]
  ADD CONSTRAINT [FK_Candidate_Experience_Experience] FOREIGN KEY ([Exp_Id]) REFERENCES [dbo].[Experience] ([Exp_Id])
GO