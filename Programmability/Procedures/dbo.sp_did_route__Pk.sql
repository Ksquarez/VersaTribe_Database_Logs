SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_did_route__Pk]
(
@id int
)
As
BEGIN TRY

	SELECT * FROM did_route WHERE did_route.id = @id;

END TRY
BEGIN CATCH

  EXECUTE [dbo].[uspLogError];

END CATCH
GO