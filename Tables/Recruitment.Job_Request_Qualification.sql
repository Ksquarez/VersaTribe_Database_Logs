CREATE TABLE [Recruitment].[Job_Request_Qualification] (
  [Job_Request_Qual_Id] [int] IDENTITY,
  [Job_Request_Id] [int] NOT NULL,
  [QI] [int] NULL,
  [YOP] [date] NULL,
  [Grade] [varchar](5) NULL,
  [City] [nvarchar](50) NULL,
  [Mandatory] [bit] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Job_Request_Qualification_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Job_Request_Qualification] PRIMARY KEY CLUSTERED ([Job_Request_Qual_Id])
)
ON [PRIMARY]
GO

ALTER TABLE [Recruitment].[Job_Request_Qualification]
  ADD CONSTRAINT [FK_Job_Request_Qualification_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [Recruitment].[Job_Request_Qualification]
  ADD CONSTRAINT [FK_Job_Request_Qualification_Qualification] FOREIGN KEY ([QI]) REFERENCES [dbo].[Qualification] ([QI_Id])
GO