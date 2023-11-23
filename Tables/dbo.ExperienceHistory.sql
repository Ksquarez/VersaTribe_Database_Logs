CREATE TABLE [dbo].[ExperienceHistory] (
  [Exp_Id] [int] NOT NULL,
  [Company_Name] [nvarchar](50) NULL,
  [Industry_Field_Name] [nvarchar](50) NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL DEFAULT (0)
)
ON [PRIMARY]
GO