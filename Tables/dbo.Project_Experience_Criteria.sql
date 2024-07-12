CREATE TABLE [dbo].[Project_Experience_Criteria] (
  [Proj_Exp_Id] [int] IDENTITY,
  [Project_Id] [int] NULL,
  [Exp_Id] [int] NULL,
  [Exp_months] [int] NULL,
  [Job_Title] [nvarchar](50) NULL,
  [Mandatory] [bit] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Project_Experience_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Project_Experience_Criteria] PRIMARY KEY CLUSTERED ([Proj_Exp_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Project_Experience_Criteria]
  ON [dbo].[Project_Experience_Criteria] ([Project_Id], [Exp_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Project_Experience_Criteria]
  ADD CONSTRAINT [FK_Project_Experience_Criteria_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [dbo].[Project_Experience_Criteria]
  ADD CONSTRAINT [FK_Project_Experience_Criteria_Experience] FOREIGN KEY ([Exp_Id]) REFERENCES [dbo].[Experience] ([Exp_Id])
GO