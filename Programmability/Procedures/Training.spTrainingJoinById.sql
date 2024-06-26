﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Training].[spTrainingJoinById]

@Training_Id INT,
@Person_Id INT

AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT * FROM Training_Join WHERE Training_Id = @Training_Id AND Person_Id = @Person_Id

End TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO