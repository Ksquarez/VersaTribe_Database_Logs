SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spExceptions_Create]
@ExceptionMessage nvarchar(MAX),
@ExceptionUrl nvarchar(MAX),
@ExceptionSource nvarchar(MAX),
@ExceptionType nvarchar(MAX),
@StackTrace nvarchar(MAX),
@LogDateTime datetime2(7),
@UserName nvarchar(MAX)
AS
BEGIN TRY
	INSERT INTO APP_Exceptions(ExceptionMessage,ExceptionUrl,ExceptionSource,ExceptionType,StackTrace,LogDateTime,UserName)
		VALUES(@ExceptionMessage,@ExceptionUrl,@ExceptionSource,@ExceptionType,@StackTrace,@LogDateTime,@UserName)
END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO