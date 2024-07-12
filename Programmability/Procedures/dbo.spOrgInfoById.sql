SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgInfoById]
@Org_Id int
AS
BEGIN TRY
	SET NOCOUNT ON;
     SELECT Org.Org_Name,OrgInfo.Org_Id, OrgInfo.About_org,OrgInfo.City, OrgInfo.Contact_email,OrgInfo.Contact_number,
			OrgInfo.Country,OrgInfo.Status, OrgInfo.TStamp,OrgInfo.TOwner, OrgInfo.Org_Pic	 
	 From OrgInfo
	 Inner JOIN Org ON OrgInfo.Org_Id = Org.Org_Id
	 WHERE OrgInfo.Org_Id= @Org_Id;

END TRY
BEGIN CATCH
  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO