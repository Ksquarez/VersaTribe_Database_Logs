CREATE TABLE [Recruitment].[Candidate_Hobby] (
  [Candidate_Hobby_Id] [int] IDENTITY,
  [Candidate_Id] [int] NULL,
  [Hobby_Id] [int] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Candidate_Hobby_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Candidate_Hobby] PRIMARY KEY CLUSTERED ([Candidate_Hobby_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Candidate_Hobby]
  ON [Recruitment].[Candidate_Hobby] ([Hobby_Id], [Candidate_Id])
  ON [PRIMARY]
GO

ALTER TABLE [Recruitment].[Candidate_Hobby]
  ADD CONSTRAINT [FK_Candidate_Hobby_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [Recruitment].[Candidate_Hobby]
  ADD CONSTRAINT [FK_Candidate_Hobby_Hobby] FOREIGN KEY ([Hobby_Id]) REFERENCES [dbo].[Hobby] ([Hobby_Id])
GO