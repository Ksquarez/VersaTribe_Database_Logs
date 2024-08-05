CREATE TABLE [Recruitment].[Job_Request_Experience] (
  [Job_Request_Experience_Id] [int] IDENTITY,
  [Job_Request_Id] [int] NULL,
  [Exp_Id] [int] NULL,
  [Exp_months] [int] NULL,
  [Job_Title] [nvarchar](50) NULL,
  [Mandatory] [bit] NULL,
  [Status] [int] NULL CONSTRAINT [DF_Job_Request_Experience_Status] DEFAULT (0),
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  CONSTRAINT [PK_Job_Request_Experience] PRIMARY KEY CLUSTERED ([Job_Request_Experience_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Job_Request_Experience]
  ON [Recruitment].[Job_Request_Experience] ([Job_Request_Id], [Exp_Id])
  ON [PRIMARY]
GO

ALTER TABLE [Recruitment].[Job_Request_Experience]
  ADD CONSTRAINT [FK_Job_Request_Experience_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [Recruitment].[Job_Request_Experience]
  ADD CONSTRAINT [FK_Job_Request_Experience_Experience] FOREIGN KEY ([Exp_Id]) REFERENCES [dbo].[Experience] ([Exp_Id])
GO