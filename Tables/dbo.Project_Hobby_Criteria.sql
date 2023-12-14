CREATE TABLE [dbo].[Project_Hobby_Criteria] (
  [Proj_Hobby_Cri_Id] [int] IDENTITY,
  [Project_Id] [int] NOT NULL,
  [Hobby_Id] [int] NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Project_Hobby_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Mandatory] [bit] NULL,
  CONSTRAINT [PK_Project_Hobby_Criteria_Id] PRIMARY KEY CLUSTERED ([Proj_Hobby_Cri_Id])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Project_Hobby_Criteria]
  ADD CONSTRAINT [FK_Project_Hobby_Criteria_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [dbo].[Project_Hobby_Criteria]
  ADD CONSTRAINT [FK_Project_Hobby_Criteria_Hobby] FOREIGN KEY ([Hobby_Id]) REFERENCES [dbo].[Hobby] ([Hobby_Id])
GO

ALTER TABLE [dbo].[Project_Hobby_Criteria]
  ADD CONSTRAINT [FK_Project_Hobby_Criteria_Project] FOREIGN KEY ([Project_Id]) REFERENCES [dbo].[Projects] ([Project_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO