CREATE TABLE [dbo].[Mst_File_Types] (
  [Id] [int] IDENTITY,
  [File_Type] [nvarchar](50) NULL,
  [IsActive] [bit] NULL,
  [TStamp] [datetime] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Status] [int] NULL,
  [Mime_Type] [nvarchar](50) NULL,
  [MT_IsActive] [bit] NULL,
  CONSTRAINT [PK_Mst_File_Types] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO