CREATE TABLE [Histroy].[Person] (
  [Person_Id] [nvarchar](4000) NULL,
  [FirstName] [nvarchar](4000) NULL,
  [LastName] [nvarchar](4000) NULL,
  [Gender] [nvarchar](4000) NULL,
  [City] [nvarchar](4000) NULL,
  [Country] [nvarchar](4000) NULL,
  [DOJ] [nvarchar](4000) NULL,
  [DOB] [nvarchar](4000) NULL,
  [TStamp] [nvarchar](4000) NULL,
  [TOwner] [nvarchar](4000) NULL,
  [Status] [nvarchar](4000) NULL,
  [Profile_Pic_Path] [nvarchar](max) NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO