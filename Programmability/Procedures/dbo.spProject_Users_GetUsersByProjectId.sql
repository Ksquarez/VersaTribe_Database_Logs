SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spProject_Users_GetUsersByProjectId]
    @Project_Id INT
AS
BEGIN TRY
    SET NOCOUNT ON;

    SELECT    Project_User.Id, Projects.Person_Id, Projects.Project_Name, Person.FirstName
    FROM  Project_User
	INNER JOIN Projects ON Projects.Project_Id = Project_User.Project_Id
	INNER JOIN Person ON Person.Person_Id = Project_User.Person_Id		   
	WHERE Project_User.Project_Id = @Project_Id

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO