CREATE TABLE [dbo].[OrgInfoHistory] (
  [Org_Id] [int] NOT NULL,
  [About_org] [nvarchar](max) NOT NULL,
  [City] [nvarchar](50) NOT NULL,
  [Country] [nvarchar](50) NOT NULL,
  [Contact_email] [varchar](50) NOT NULL,
  [Contact_number] [varchar](15) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NULL DEFAULT (0)
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO