CREATE TABLE [dbo].[Qualification_Criteria] (
  [Training_Id] [int] NULL,
  [Cou_Id] [int] NULL,
  [Status] [int] NULL CONSTRAINT [DF_Qualification_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Mandatory] [bit] NULL,
  [Id] [int] IDENTITY,
  CONSTRAINT [PK_Qualification_Criteria_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IDX_Qualification_Criteria]
  ON [dbo].[Qualification_Criteria] ([Training_Id], [Cou_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Qualification_Criteria]
  ADD CONSTRAINT [FK_Qualification_Criteria_Course] FOREIGN KEY ([Cou_Id]) REFERENCES [dbo].[Course] ([Cou_Id])
GO