CREATE TABLE [dbo].[Projects] (
  [Project_Id] [int] IDENTITY,
  [Project_Name] [nvarchar](50) NOT NULL,
  [Person_Id] [int] NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Projects_Status] DEFAULT (0),
  [Start_Date] [date] NULL,
  [End_Date] [date] NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Org_Id] [int] NOT NULL,
  [Progress] [int] NULL CONSTRAINT [DF__Projects__Progre__4DB4832C] DEFAULT (0),
  CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED ([Project_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Projects_1]
  ON [dbo].[Projects] ([Project_Name], [Org_Id])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_ProjectActivity]
ON [dbo].[Projects]
AFTER INSERT, UPDATE, DELETE AS
BEGIN
INSERT INTO [Histroy].[Projects]
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[Projects]
  ADD CONSTRAINT [FK_Projects_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Projects]
  ADD CONSTRAINT [FK_Projects_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO

ALTER TABLE [dbo].[Projects]
  ADD CONSTRAINT [FK_Projects_Person] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO