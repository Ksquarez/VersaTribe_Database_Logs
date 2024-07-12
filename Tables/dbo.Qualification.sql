CREATE TABLE [dbo].[Qualification] (
  [QI_Id] [int] IDENTITY,
  [Cou_Id] [int] NOT NULL,
  [Inst_Id] [int] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [Status] [int] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_Qualification_1] PRIMARY KEY CLUSTERED ([QI_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Qualification]
  ON [dbo].[Qualification] ([Cou_Id], [Inst_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Qualification]
  ADD CONSTRAINT [FK_Qualification_Course] FOREIGN KEY ([Cou_Id]) REFERENCES [dbo].[Course] ([Cou_Id])
GO

ALTER TABLE [dbo].[Qualification]
  ADD CONSTRAINT [FK_Qualification_Institutes] FOREIGN KEY ([Inst_Id]) REFERENCES [dbo].[Institutes] ([Inst_Id])
GO