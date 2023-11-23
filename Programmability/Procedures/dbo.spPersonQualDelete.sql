﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spPersonQualDelete]
@PQ_Id int
As
Begin Try
	Delete PersonQualification Where PQ_Id =@PQ_Id
End Try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO