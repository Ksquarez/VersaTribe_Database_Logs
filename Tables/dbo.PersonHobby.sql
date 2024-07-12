CREATE TABLE [dbo].[PersonHobby] (
  [Person_Id] [int] NOT NULL,
  [Hobby_Id] [int] NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_PersonHobby_Status] DEFAULT (0),
  [TOwner] [nvarchar](256) NOT NULL,
  [TStamp] [datetime2] NOT NULL
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UK_PersonHobby]
  ON [dbo].[PersonHobby] ([Person_Id], [Hobby_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[PersonHobby]
  ADD CONSTRAINT [FK_PersonHobby_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[PersonHobby]
  ADD CONSTRAINT [FK_PersonHobby_Hobby] FOREIGN KEY ([Hobby_Id]) REFERENCES [dbo].[Hobby] ([Hobby_Id])
GO

ALTER TABLE [dbo].[PersonHobby]
  ADD CONSTRAINT [FK_PersonHobby_Person] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO