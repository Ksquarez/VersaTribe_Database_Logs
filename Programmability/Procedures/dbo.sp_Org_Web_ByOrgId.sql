SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Org_Web_ByOrgId] 
(
    @Org_Id INT
)
AS
BEGIN TRY
	
	SELECT Org.*, 
	       OrgInfo.About_org, 
	       OrgInfo.City, 
	       OrgInfo.Contact_email, 
	       OrgInfo.Contact_number, 
	       OrgInfo.Country,
		   (SELECT ISNULL(SUM(Limit), 0) FROM OrgServers WHERE Org_Id = @Org_Id) AS 'Limit'
		   
	FROM Org
	INNER JOIN OrgInfo ON OrgInfo.Org_Id = Org.Org_Id
	WHERE Org.Org_Id = @Org_Id

END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO