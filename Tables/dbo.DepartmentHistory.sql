CREATE TABLE [dbo].[DepartmentHistory] (
  [Dept_Id] [int] NOT NULL,
  [Org_Id] [int] NULL,
  [Dept_Name] [nvarchar](50) NOT NULL,
  [Parent_dept_Id] [int] NULL,
  [Status] [int] NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Is_Default] [bit] NULL
)
ON [PRIMARY]
GO