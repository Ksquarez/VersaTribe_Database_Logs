CREATE TABLE [dbo].[Project_Skills_Criteria] (
  [Proj_Skill_Cri_Id] [int] IDENTITY,
  [Project_Id] [int] NULL,
  [Skill_Id] [int] NULL,
  [Experience] [tinyint] NULL,
  [Status] [int] NULL CONSTRAINT [DF_Project_Skills_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Mandatory] [bit] NULL,
  CONSTRAINT [PK_Project_Skills_Criteria] PRIMARY KEY CLUSTERED ([Proj_Skill_Cri_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Project_Skills_Criteria]
  ON [dbo].[Project_Skills_Criteria] ([Project_Id], [Skill_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Project_Skills_Criteria]
  ADD CONSTRAINT [FK_Project_Skills_Criteria_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [dbo].[Project_Skills_Criteria]
  ADD CONSTRAINT [FK_Project_Skills_Criteria_Skills] FOREIGN KEY ([Skill_Id]) REFERENCES [dbo].[Skills] ([Skill_Id])
GO