CREATE TABLE [dbo].[PersonExperience] (
  [PerExp_Id] [int] IDENTITY,
  [Person_Id] [int] NOT NULL,
  [Exp_Id] [int] NOT NULL,
  [Exp_months] [int] NULL,
  [Job_Title] [nvarchar](50) NOT NULL,
  [Status] [int] NOT NULL,
  [Start_date] [date] NULL,
  [End_Date] [date] NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_PersonExperience] PRIMARY KEY CLUSTERED ([PerExp_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_PersonExperience]
  ON [dbo].[PersonExperience] ([Person_Id], [Exp_Id], [Start_date], [End_Date])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_PersonExperienceActivity]
ON [dbo].[PersonExperience]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO [Histroy].[PersonExperience]
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[PersonExperience]
  ADD CONSTRAINT [FK_PersonExperience_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[PersonExperience]
  ADD CONSTRAINT [FK_PersonExperience_Experience] FOREIGN KEY ([Exp_Id]) REFERENCES [dbo].[Experience] ([Exp_Id])
GO

ALTER TABLE [dbo].[PersonExperience]
  ADD CONSTRAINT [FK_PersonExperience_Person] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO