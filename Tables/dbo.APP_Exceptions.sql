CREATE TABLE [dbo].[APP_Exceptions] (
  [ExceptionId] [int] IDENTITY,
  [ExceptionMessage] [nvarchar](max) NULL,
  [ExceptionUrl] [nvarchar](max) NULL,
  [ExceptionSource] [nvarchar](max) NULL,
  [ExceptionType] [nvarchar](max) NULL,
  [StackTrace] [nvarchar](max) NULL,
  [LogDateTime] [nvarchar](max) NULL,
  [UserName] [nvarchar](max) NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO