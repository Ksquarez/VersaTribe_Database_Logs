CREATE TABLE [dbo].[Training_Request] (
  [Training_Req_Id] [int] IDENTITY,
  [Org_Id] [int] NOT NULL,
  [Person_Id] [int] NOT NULL,
  [Training_Req_Name] [nvarchar](500) NOT NULL,
  [Description] [nvarchar](max) NOT NULL,
  [Created_At] [datetime2] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Training_Request_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Training_Request] PRIMARY KEY CLUSTERED ([Training_Req_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Training_Request]
  ADD CONSTRAINT [FK_Training_Request_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Training_Request]
  ADD CONSTRAINT [FK_Training_Request_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO

ALTER TABLE [dbo].[Training_Request]
  ADD CONSTRAINT [FK_Training_Request_Person] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO