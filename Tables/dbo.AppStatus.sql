CREATE TABLE [dbo].[AppStatus] (
  [StatusId] [int] IDENTITY,
  [Name] [nvarchar](max) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_AppStatus] PRIMARY KEY CLUSTERED ([StatusId])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO