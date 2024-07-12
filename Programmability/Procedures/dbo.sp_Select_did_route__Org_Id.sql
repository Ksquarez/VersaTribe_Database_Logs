SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Select_did_route__Org_Id]
(
@Org_Id int
)
As
BEGIN TRY
	SELECT * from did_route Where did_route.Org_Id = @Org_Id;
END TRY
BEGIN CATCH

 EXECUTE [dbo].[uspLogError];

END CATCH
GO