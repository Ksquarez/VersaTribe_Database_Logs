CREATE TABLE [Recruitment].[Job_Request_Skills] (
  [Job_Request_Skill_Id] [int] IDENTITY,
  [Job_Request_Id] [int] NULL,
  [Skill_Id] [int] NULL,
  [Experience] [tinyint] NULL,
  [Mandatory] [bit] NULL,
  [Status] [int] NULL CONSTRAINT [DF_Job_Request_Skills_Status] DEFAULT (0),
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  CONSTRAINT [PK_Job_Request_Skills] PRIMARY KEY CLUSTERED ([Job_Request_Skill_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Job_Request_Skills]
  ON [Recruitment].[Job_Request_Skills] ([Job_Request_Id], [Skill_Id])
  ON [PRIMARY]
GO

ALTER TABLE [Recruitment].[Job_Request_Skills]
  ADD CONSTRAINT [FK_Job_Request_Skills_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [Recruitment].[Job_Request_Skills]
  ADD CONSTRAINT [FK_Job_Request_Skills_Skills] FOREIGN KEY ([Skill_Id]) REFERENCES [dbo].[Skills] ([Skill_Id])
GO