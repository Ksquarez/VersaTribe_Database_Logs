SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Select_Mst_File_Types]
As
BEGIN TRY
	SELECT * from Mst_File_Types Where IsActive = 1 ;
END TRY
BEGIN CATCH

  EXECUTE [dbo].[uspLogError];

END CATCH
GO