CREATE TABLE [dbo].[Project_Hobby_Criteria] (
  [Proj_Hobby_Cri_Id] [int] IDENTITY,
  [Project_Id] [int] NULL,
  [Hobby_Id] [int] NULL,
  [Status] [int] NULL CONSTRAINT [DF_Project_Hobby_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Mandatory] [bit] NULL,
  CONSTRAINT [PK_Project_Hobby_Criteria_Id] PRIMARY KEY CLUSTERED ([Proj_Hobby_Cri_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Project_Hobby_Criteria]
  ON [dbo].[Project_Hobby_Criteria] ([Project_Id], [Hobby_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Project_Hobby_Criteria]
  ADD CONSTRAINT [FK_Project_Hobby_Criteria_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [dbo].[Project_Hobby_Criteria]
  ADD CONSTRAINT [FK_Project_Hobby_Criteria_Hobby] FOREIGN KEY ([Hobby_Id]) REFERENCES [dbo].[Hobby] ([Hobby_Id])
GO