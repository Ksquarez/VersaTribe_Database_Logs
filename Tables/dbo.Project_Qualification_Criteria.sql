CREATE TABLE [dbo].[Project_Qualification_Criteria] (
  [Proj_Qual_Id] [int] IDENTITY,
  [Project_Id] [int] NOT NULL,
  [QI] [int] NOT NULL,
  [YOP] [date] NOT NULL,
  [Grade] [varchar](5) NOT NULL,
  [City] [nvarchar](50) NOT NULL,
  [Mandatory_Fields] [nvarchar](max) NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Project_Qualification_Criteria_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Project_Qualification_Criteria_Id] PRIMARY KEY CLUSTERED ([Proj_Qual_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
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