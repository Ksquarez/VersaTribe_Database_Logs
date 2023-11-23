CREATE TABLE [dbo].[CourseTypeHistory] (
  [CTyp_Id] [int] NOT NULL,
  [Ctyp_Name] [nvarchar](50) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [StatusId] [int] NULL
)
ON [PRIMARY]
GO