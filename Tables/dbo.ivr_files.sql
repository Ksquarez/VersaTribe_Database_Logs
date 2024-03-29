﻿CREATE TABLE [dbo].[ivr_files] (
  [Id] [int] IDENTITY,
  [ivr_id] [int] NULL,
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
  CONSTRAINT [PK_ivr_files] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ivr_files]
  ADD FOREIGN KEY ([ivr_id]) REFERENCES [dbo].[ivr_details] ([ivr_id])
GO

ALTER TABLE [dbo].[ivr_files]
  ADD FOREIGN KEY ([Mst_File_Types_Id]) REFERENCES [dbo].[Mst_File_Types] ([Id])
GO