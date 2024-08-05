CREATE TABLE [dbo].[Hobby_Criteria] (
  [Id] [int] IDENTITY,
  [Training_Id] [int] NULL,
  [Hobby_Id] [int] NULL,
  [Status] [int] NULL CONSTRAINT [DF_Hobby_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Mandatory] [bit] NULL,
  CONSTRAINT [PK_Hobby_Criteria_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UK_Hobby_Criteria]
  ON [dbo].[Hobby_Criteria] ([Training_Id], [Hobby_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Hobby_Criteria]
  ADD CONSTRAINT [FK_Hobby_Criteria_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Hobby_Criteria]
  ADD CONSTRAINT [FK_Hobby_Criteria_Hobby] FOREIGN KEY ([Hobby_Id]) REFERENCES [dbo].[Hobby] ([Hobby_Id])
GO