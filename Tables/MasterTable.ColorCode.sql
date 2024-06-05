CREATE TABLE [MasterTable].[ColorCode] (
  [id] [int] NOT NULL,
  [Name] [nvarchar](50) NULL,
  [ColorCodeValue] [nvarchar](50) NULL,
  CONSTRAINT [PK_ColorCode_id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO