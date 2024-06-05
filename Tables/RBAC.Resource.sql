CREATE TABLE [RBAC].[Resource] (
  [ResourceID] [int] NOT NULL,
  [Name] [varchar](100) NULL,
  [Description] [varchar](255) NULL,
  [ParentResID] [int] NULL,
  PRIMARY KEY CLUSTERED ([ResourceID])
)
ON [PRIMARY]
GO