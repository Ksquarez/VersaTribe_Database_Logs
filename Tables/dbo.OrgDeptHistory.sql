CREATE TABLE [dbo].[OrgDeptHistory] (
  [Org_Id] [int] NOT NULL,
  [Dept_Id] [int] NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NULL DEFAULT (0)
)
ON [PRIMARY]
GO