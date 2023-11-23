CREATE TABLE [dbo].[Training] (
  [Training_Id] [int] IDENTITY,
  [Org_Id] [int] NULL,
  [Trainer_Id] [int] NULL,
  [Training_Name] [nvarchar](50) NOT NULL,
  [Description] [nvarchar](max) NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Training_Status] DEFAULT (0),
  [Start_Date] [date] NULL,
  [End_Date] [date] NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [PersonLimit] [int] NULL,
  CONSTRAINT [PK_Training] PRIMARY KEY CLUSTERED ([Training_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Training]
  ADD CONSTRAINT [FK_Training_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO