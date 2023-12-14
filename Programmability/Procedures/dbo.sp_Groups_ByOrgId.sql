SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Groups_ByOrgId] 
(
    @Org_Id INT
)
AS
BEGIN TRY
	
	SELECT   dbo.Org.Org_Name, 
	         dbo.Groups.Group_Id, 
			 dbo.Groups.Group_Name, 
			 dbo.Groups.Org_Id, 
			 dbo.Groups.Strategy, 
			 dbo.Groups.TimeOut,
			 dbo.Groups.IsDefault
    FROM    dbo.Groups 
	INNER JOIN dbo.Org ON dbo.Groups.Org_Id = dbo.Org.Org_Id
	WHERE dbo.Groups.Org_Id = @Org_Id

END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO