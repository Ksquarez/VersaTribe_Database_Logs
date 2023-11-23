CREATE TABLE [dbo].[DB_Errors] (
  [ErrorID] [int] IDENTITY,
  [UserName] [varchar](100) NULL,
  [ErrorNumber] [int] NULL,
  [ErrorState] [int] NULL,
  [ErrorSeverity] [int] NULL,
  [ErrorLine] [int] NULL,
  [ErrorProcedure] [varchar](max) NULL,
  [ErrorMessage] [varchar](max) NULL,
  [ErrorDateTime] [datetime] NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO