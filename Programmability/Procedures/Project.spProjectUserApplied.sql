SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE Proc [Project].[spProjectUserApplied]
@Org_Id int,
@Person_Id int
AS
BEGIN TRY
	select Project_User.Id,  projects.*, Project_User.IsApproved  from Projects
	left join Project_User On Project_User.Project_Id = Projects.Project_Id AND
	Project_User.Person_Id = @Person_Id
	where Org_Id = @Org_Id
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO