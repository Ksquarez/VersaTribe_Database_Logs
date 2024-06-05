SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE proc [Session].[spSessionGetCurrentOrgAdminOrgs]
(
  @Username nvarchar(256)
)
As
BEGIN TRY
  /*
    This stored procedure does the following:
    - Get All the Orgs That Person Belongs To OrgAdmin
    */
	SELECT Org.Org_Name,Org.Org_Id FROM Org
	WHERE Org.OrgAdmin_Id = @Username

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO