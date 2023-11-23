CREATE TABLE [dbo].[OrgHistory] (
  [Org_Id] [int] NOT NULL,
  [Org_Name] [nvarchar](50) NOT NULL,
  [Status] [int] NULL,
  [OrgAdmin_Id] [nvarchar](256) NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL
)
ON [PRIMARY]
GO