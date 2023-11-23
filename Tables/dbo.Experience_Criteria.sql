CREATE TABLE [dbo].[Experience_Criteria] (
  [Training_Id] [int] NOT NULL,
  [Exp_Id] [int] NOT NULL,
  [Exp_months] [int] NULL,
  [Job_Title] [nvarchar](50) NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Experience_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Mandatory] [bit] NULL,
  [Id] [int] IDENTITY,
  CONSTRAINT [PK_Experience_Criteria] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Experience_Criteria]
  ON [dbo].[Experience_Criteria] ([Training_Id], [Exp_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Experience_Criteria]
  ADD FOREIGN KEY ([Training_Id]) REFERENCES [dbo].[Training] ([Training_Id])
GO

ALTER TABLE [dbo].[Experience_Criteria]
  ADD CONSTRAINT [FK_Experience_Criteria_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Experience_Criteria]
  ADD CONSTRAINT [FK_Experience_Criteria_Experience] FOREIGN KEY ([Exp_Id]) REFERENCES [dbo].[Experience] ([Exp_Id])
GO