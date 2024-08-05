CREATE TABLE [dbo].[Project_Qualification_Criteria] (
  [Proj_Qual_Id] [int] IDENTITY,
  [Project_Id] [int] NULL,
  [QI] [int] NULL,
  [YOP] [date] NULL,
  [Grade] [varchar](5) NULL,
  [City] [nvarchar](50) NULL,
  [Mandatory] [bit] NULL,
  [Status] [int] NULL CONSTRAINT [DF_Project_Qualification_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  CONSTRAINT [PK_Project_Qualification_Criteria_Id] PRIMARY KEY CLUSTERED ([Proj_Qual_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Project_Qualification_Criteria]
  ON [dbo].[Project_Qualification_Criteria] ([Project_Id], [QI])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Project_Qualification_Criteria]
  ADD CONSTRAINT [FK_Project_Qualification_Criteria_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [dbo].[Project_Qualification_Criteria]
  ADD CONSTRAINT [FK_Project_Qualification_Criteria_Qualification] FOREIGN KEY ([QI]) REFERENCES [dbo].[Qualification] ([QI_Id])
GO