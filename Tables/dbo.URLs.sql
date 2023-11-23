CREATE TABLE [dbo].[URLs] (
  [URLID] [int] IDENTITY,
  [ParentURLID] [int] NULL,
  [URLPath] [nvarchar](255) NULL,
  [URLName] [nvarchar](255) NULL,
  [URLOrder] [int] NULL,
  PRIMARY KEY CLUSTERED ([URLID])
)
ON [PRIMARY]
GO