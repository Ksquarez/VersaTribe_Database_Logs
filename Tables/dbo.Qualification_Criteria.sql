CREATE TABLE [dbo].[Qualification_Criteria] (
  [Training_Id] [int] NOT NULL,
  [Cou_Id] [int] NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Qualification_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Mandatory] [bit] NOT NULL,
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
  ADD CONSTRAINT [FK__Qualifica__Train__36D11DD4] FOREIGN KEY ([Training_Id]) REFERENCES [dbo].[Training] ([Training_Id]) ON DELETE CASCADE ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Qualification_Criteria]
  ADD CONSTRAINT [FK_Qualification_Criteria_Course] FOREIGN KEY ([Cou_Id]) REFERENCES [dbo].[Course] ([Cou_Id])
GO