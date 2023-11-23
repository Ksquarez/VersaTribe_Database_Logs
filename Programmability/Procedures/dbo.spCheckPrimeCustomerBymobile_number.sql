SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create Proc [dbo].[spCheckPrimeCustomerBymobile_number]
@mobile_number bigint
As
Begin Try
	select * from Check_Prime_Customer where mobile_number = @mobile_number
End TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO