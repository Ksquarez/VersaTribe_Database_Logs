﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE proc [dbo].[spHobbyById]
@Hobby_Id  int
As
Begin Try
	Select * from Hobby Where Hobby_Id= @Hobby_Id
End try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO