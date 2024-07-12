CREATE TABLE [dbo].[Course] (
  [Cou_Id] [int] IDENTITY,
  [Cou_Name] [nvarchar](256) NOT NULL,
  [CTyp_Id] [int] NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Course_StatusId] DEFAULT (0),
  CONSTRAINT [PK_Qualification] PRIMARY KEY CLUSTERED ([Cou_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Course]
  ON [dbo].[Course] ([Cou_Name], [CTyp_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Course]
  ADD CONSTRAINT [FK_Course_CourseType] FOREIGN KEY ([CTyp_Id]) REFERENCES [dbo].[CourseType] ([CTyp_Id])
GO

ALTER TABLE [dbo].[Course]
  ADD CONSTRAINT [FK_Qualification_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO