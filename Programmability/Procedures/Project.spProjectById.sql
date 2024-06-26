﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Project].[spProjectById]
    @Project_Id INT
AS
BEGIN Try
    SET NOCOUNT ON;

    SELECT *
    FROM Projects  
    WHERE Project_Id = @Project_Id;
END Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO