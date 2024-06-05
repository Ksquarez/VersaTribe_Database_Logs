CREATE TABLE [dbo].[Window_Events_Logs] (
  [Id] [int] IDENTITY,
  [Event_Id] [int] NULL,
  [Event_Record_Id] [int] NULL,
  [Machine_Name] [nvarchar](max) NULL,
  [Org_Id] [int] NULL,
  [Person_Id] [int] NULL,
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Status] [int] NULL DEFAULT (0),
  [Owner] [nvarchar](256) NULL,
  CONSTRAINT [PK_Window_Events_Logs_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Window_Events_Logs]
  ADD FOREIGN KEY ([Event_Id]) REFERENCES [MasterTable].[Window_Events] ([Event_Id])
GO

ALTER TABLE [dbo].[Window_Events_Logs]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO

ALTER TABLE [dbo].[Window_Events_Logs]
  ADD FOREIGN KEY ([Owner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [dbo].[Window_Events_Logs]
  ADD CONSTRAINT [FK__Window_Ev__Perso__2A212E2C] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO

ALTER TABLE [dbo].[Window_Events_Logs]
  ADD FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO