﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE proc [dbo].[spPersonById]
@Person_Id  int
As
Begin Try 
	Select * from Person Where Person_Id= @Person_Id
End Try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO