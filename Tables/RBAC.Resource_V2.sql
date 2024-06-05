CREATE TABLE [RBAC].[Resource_V2] (
  [ResourceID] [int] NOT NULL,
  [Name] [varchar](100) NULL,
  [Description] [varchar](255) NULL,
  [ParentResID] [int] NULL,
  [IsFunctionality] [bit] NULL,
  [Url] [nvarchar](max) NULL,
  PRIMARY KEY CLUSTERED ([ResourceID])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO