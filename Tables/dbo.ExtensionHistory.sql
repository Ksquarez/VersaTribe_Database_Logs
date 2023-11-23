CREATE TABLE [dbo].[ExtensionHistory] (
  [Ext_Id] [int] NOT NULL,
  [Ext_Num] [int] NOT NULL,
  [Status] [int] NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL
)
ON [PRIMARY]
GO