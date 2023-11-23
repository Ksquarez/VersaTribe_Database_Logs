CREATE TABLE [dbo].[InstitutesHistory] (
  [Inst_Id] [int] NOT NULL,
  [Inst_Name] [nvarchar](50) NOT NULL,
  [Inst_Type] [nvarchar](50) NULL,
  [City] [nvarchar](50) NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [Status] [int] NOT NULL DEFAULT (0)
)
ON [PRIMARY]
GO