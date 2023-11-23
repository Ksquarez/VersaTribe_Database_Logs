CREATE TABLE [dbo].[CourseHistory] (
  [Cou_Id] [int] NOT NULL,
  [Cou_Name] [nvarchar](256) NOT NULL,
  [CTyp_Id] [int] NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL DEFAULT ('0')
)
ON [PRIMARY]
GO