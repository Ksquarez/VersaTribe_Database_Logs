CREATE TABLE [dbo].[Org_Files] (
  [Id] [int] IDENTITY,
  [Org_Id] [int] NULL,
  [Mst_File_Types_Id] [int] NULL,
  [File_Name] [nvarchar](max) NULL,
  [File_Size] [int] NULL,
  [File_Content] [nvarchar](max) NULL,
  [File_Extension] [nvarchar](max) NULL,
  [Content] [varbinary](max) NULL,
  [TStamp] [datetime] NULL,
  [TOwner] [nvarchar](256) NULL,
  [File_Comment] [nvarchar](max) NULL,
  [Status] [int] NULL,
  CONSTRAINT [PK_Org_Files] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Org_Files]
  ADD FOREIGN KEY ([Mst_File_Types_Id]) REFERENCES [dbo].[Mst_File_Types] ([Id])
GO

ALTER TABLE [dbo].[Org_Files]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO