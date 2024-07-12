SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Select_Mst_did_route_types]
As
BEGIN TRY
	SELECT Id , route_type from Mst_did_route_types ;
END TRY
BEGIN CATCH

 EXECUTE [dbo].[uspLogError];

END CATCH
GO