CREATE TABLE [dbo].[Training_Join] (
  [Training_Id] [int] NOT NULL,
  [Person_Id] [int] NOT NULL,
  [Is_Join] [bit] NULL,
  [Joined_At] [datetime] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Training_Join_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Training_Join] PRIMARY KEY CLUSTERED ([Training_Id], [Person_Id])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Training_Join]
  ADD CONSTRAINT [FK_Training_Join_Person] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO

ALTER TABLE [dbo].[Training_Join]
  ADD CONSTRAINT [FK_Training_Join_Training] FOREIGN KEY ([Training_Id]) REFERENCES [dbo].[Training] ([Training_Id])
GO