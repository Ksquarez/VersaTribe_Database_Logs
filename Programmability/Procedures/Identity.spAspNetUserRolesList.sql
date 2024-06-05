SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Identity].[spAspNetUserRolesList]
AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT user_role.UserId,user_role.RoleId,UserName,AspNetRoles.Name FROM AspNetUserRoles as user_role
	INNER JOIN AspNetUsers ON user_role.UserId = AspNetUsers.Id
	INNER JOIN AspNetRoles ON user_role.RoleId = AspNetRoles.Id

   
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO