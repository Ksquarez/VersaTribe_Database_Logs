SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Extensions__Pk] 
(
    @Extension_Id INT
)
AS
BEGIN TRY
	
	SELECT * FROM Extensions WHERE Extension_Id = @Extension_Id

END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO