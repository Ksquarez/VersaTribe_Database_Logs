SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Extensions__Users_ByOrgId] 
(
    @Org_Id INT
)
AS
BEGIN TRY
	
	SELECT Extensions.*, Person.FirstName, Person.LastName, Person.TOwner, Org.Org_Name FROM Extensions 
	INNER JOIN Person ON Person.Person_Id = Extensions.Person_Id
	INNER JOIN Org ON Org.Org_Id = Extensions.Org_Id
	WHERE Extensions.Org_Id = @Org_Id

END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO