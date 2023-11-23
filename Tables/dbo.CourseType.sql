CREATE TABLE [dbo].[CourseType] (
  [CTyp_Id] [int] IDENTITY,
  [Ctyp_Name] [nvarchar](50) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_CourseType_StatusId] DEFAULT (0),
  CONSTRAINT [PK_CourseType] PRIMARY KEY CLUSTERED ([CTyp_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_CourseType]
  ON [dbo].[CourseType] ([Ctyp_Name])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_CourseTypeActivity]
ON [dbo].[CourseType]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO CourseTypeHistory
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[CourseType]
  ADD CONSTRAINT [FK_CourseType_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO