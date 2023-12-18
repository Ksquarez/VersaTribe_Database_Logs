CREATE TABLE [dbo].[Project_Qualification_Criteria] (
  [Proj_Qual_Id] [int] IDENTITY,
  [Project_Id] [int] NOT NULL,
  [Cou_Id] [int] NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Project_Qualification_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Mandatory] [bit] NULL,
  CONSTRAINT [PK_Project_Qualification_Criteria_Id] PRIMARY KEY CLUSTERED ([Proj_Qual_Id])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Project_Qualification_Criteria]
  ADD CONSTRAINT [FK_Project_Qualification_Criteria_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [dbo].[Project_Qualification_Criteria]
  ADD CONSTRAINT [FK_Project_Qualification_Criteria_Course] FOREIGN KEY ([Cou_Id]) REFERENCES [dbo].[Course] ([Cou_Id])
GO

ALTER TABLE [dbo].[Project_Qualification_Criteria]
  ADD CONSTRAINT [FK_Project_Qualification_Criteria_Project] FOREIGN KEY ([Project_Id]) REFERENCES [dbo].[Projects] ([Project_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO