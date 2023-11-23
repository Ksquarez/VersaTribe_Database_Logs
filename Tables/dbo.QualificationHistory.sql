CREATE TABLE [dbo].[QualificationHistory] (
  [QI_Id] [int] NOT NULL,
  [Cou_Id] [int] NOT NULL,
  [Inst_Id] [int] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [Status] [int] NOT NULL DEFAULT (0)
)
ON [PRIMARY]
GO