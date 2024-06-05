CREATE TABLE [Recruitment].[Candidate_Qualification] (
  [Candidate_Qualification_Id] [int] IDENTITY,
  [Candidate_Id] [int] NULL,
  [QI_Id] [int] NULL,
  [YOP] [date] NULL,
  [Grade] [varchar](5) NULL,
  [City] [nvarchar](50) NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Candidate_Qualification_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Candidate_Qualification] PRIMARY KEY CLUSTERED ([Candidate_Qualification_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Candidate_Qualification]
  ON [Recruitment].[Candidate_Qualification] ([Candidate_Id], [QI_Id])
  ON [PRIMARY]
GO

ALTER TABLE [Recruitment].[Candidate_Qualification]
  ADD CONSTRAINT [FK_Candidate_Qualification_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [Recruitment].[Candidate_Qualification]
  ADD CONSTRAINT [FK_Candidate_Qualification_Qualification] FOREIGN KEY ([QI_Id]) REFERENCES [dbo].[Qualification] ([QI_Id])
GO