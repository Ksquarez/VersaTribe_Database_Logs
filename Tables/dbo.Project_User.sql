CREATE TABLE [dbo].[Project_User] (
  [Id] [int] IDENTITY,
  [Person_Id] [int] NOT NULL,
  [Project_Id] [int] NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Project_User_Status] DEFAULT (0),
  [Role] [nvarchar](50) NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [IsApproved] [bit] NULL,
  CONSTRAINT [PK_Project_User] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_Project_User]
  ON [dbo].[Project_User] ([Person_Id], [Project_Id])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_Project_UserActivity]
ON [dbo].[Project_User]
AFTER INSERT, UPDATE, DELETE AS
BEGIN
INSERT INTO [Histroy].[Project_User]
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[Project_User]
  ADD CONSTRAINT [FK_Project_User_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Project_User]
  ADD CONSTRAINT [FK_Project_User_Person] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO

ALTER TABLE [dbo].[Project_User]
  ADD CONSTRAINT [FK_Project_User_Projects] FOREIGN KEY ([Project_Id]) REFERENCES [dbo].[Projects] ([Project_Id])
GO