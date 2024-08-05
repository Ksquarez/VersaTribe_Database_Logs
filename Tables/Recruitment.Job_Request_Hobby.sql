CREATE TABLE [Recruitment].[Job_Request_Hobby] (
  [Job_Request_Hobby_Id] [int] IDENTITY,
  [Job_Request_Id] [int] NULL,
  [Hobby_Id] [int] NULL,
  [Mandatory] [bit] NULL,
  [Status] [int] NULL CONSTRAINT [DF_Job_Request_Hobby_Status] DEFAULT (0),
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  CONSTRAINT [PK_Job_Request_Hobby] PRIMARY KEY CLUSTERED ([Job_Request_Hobby_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Job_Request_Hobby]
  ON [Recruitment].[Job_Request_Hobby] ([Job_Request_Id], [Hobby_Id])
  ON [PRIMARY]
GO

ALTER TABLE [Recruitment].[Job_Request_Hobby]
  ADD CONSTRAINT [FK_Job_Request_Hobby_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [Recruitment].[Job_Request_Hobby]
  ADD CONSTRAINT [FK_Job_Request_Hobby_Hobby] FOREIGN KEY ([Hobby_Id]) REFERENCES [dbo].[Hobby] ([Hobby_Id])
GO