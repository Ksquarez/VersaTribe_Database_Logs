CREATE TABLE [dbo].[Attendence] (
  [Id] [int] IDENTITY,
  [Login_Date_Time] [datetime2] NULL,
  [Org_Id] [int] NULL,
  [Person_Id] [int] NULL,
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Status] [int] NULL DEFAULT (0),
  [Owner] [nvarchar](256) NULL,
  [Attendence_Type] [nvarchar](50) NULL,
  CONSTRAINT [PK_Attendence_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Attendence]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO

ALTER TABLE [dbo].[Attendence]
  ADD FOREIGN KEY ([Owner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

ALTER TABLE [dbo].[Attendence]
  ADD CONSTRAINT [FK__Attendenc__Perso__349EBC9F] FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO

ALTER TABLE [dbo].[Attendence]
  ADD FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName])
GO

EXEC sys.sp_addextendedproperty N'MS_Description', 'In,Out', 'SCHEMA', N'dbo', 'TABLE', N'Attendence', 'COLUMN', N'Attendence_Type'
GO