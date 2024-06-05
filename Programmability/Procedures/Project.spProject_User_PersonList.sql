SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Project].[spProject_User_PersonList]

@Project_Id INT,
@IsApproved BIT

AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT Projects.Project_Id,
		   Person.Person_Id,
		   Projects.Project_Name,
		   Person.FirstName,
		   Person.LastName,
		   Person.TOwner,
		   Project_User.Id,
		   Project_User.IsApproved
   FROM dbo.Org INNER JOIN
    dbo.Projects ON dbo.Org.Org_Id = dbo.Projects.Org_Id INNER JOIN
    dbo.Project_User ON dbo.Projects.Project_Id = dbo.Project_User.Project_Id INNER JOIN
    dbo.Person ON dbo.Project_User.Person_Id = dbo.Person.Person_Id
	WHERE Projects.Project_Id = @Project_Id AND Project_User.IsApproved = @IsApproved
	


End TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO