SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create PROCEDURE [dbo].[sp_Groups_delete_cascade]
    @Group_Id INT
AS
BEGIN TRY
	SET NOCOUNT ON;
	
	BEGIN TRANSACTION;
	
	DELETE FROM ServerGroups
    WHERE [Group_Id] = @Group_Id;
	
    DELETE FROM Groups
    WHERE Group_Id = @Group_Id
    
    COMMIT;

END TRY
BEGIN CATCH

   ROLLBACK;

   EXECUTE [dbo].[uspLogError];

END CATCH
GO