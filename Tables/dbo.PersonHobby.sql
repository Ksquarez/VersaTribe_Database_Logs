CREATE TABLE [dbo].[PersonHobby] (
  [Person_Id] [int] NOT NULL,
  [Hobby_Id] [int] NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_PersonHobby_Status] DEFAULT (0),
  [TOwner] [nvarchar](256) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  CONSTRAINT [PK_PersonHobby] PRIMARY KEY CLUSTERED ([Person_Id], [Hobby_Id])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_PersonHobby]
  ON [dbo].[PersonHobby] ([Person_Id])
  ON [PRIMARY]
GO

CREATE INDEX [IX_PersonHobby_1]
  ON [dbo].[PersonHobby] ([Hobby_Id])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_PersonHobbyActivity]
ON [dbo].[PersonHobby]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO [Histroy].[PersonHobby]
SELECT * FROM INSERTED
END
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