SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Extensions_delete] 
(
    @Extension_Id INT
	
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	BEGIN TRANSACTION;

	 DECLARE @Org_Id INT

	 DECLARE @Person_Id INT

	 SELECT @Org_Id = Org_Id, @Person_Id = Person_Id FROM Extensions WHERE Extension_Id = @Extension_Id

	 UPDATE OrgPerson
		SET IsCaller = 0
        WHERE Org_Id = @Org_Id AND Person_Id = @Person_Id

    DELETE FROM GroupExtensions WHERE Extension_Id = @Extension_Id

	DELETE  FROM Extensions WHERE Extension_Id = @Extension_Id
	
    
    COMMIT;

END TRY
BEGIN CATCH

   ROLLBACK;

   EXECUTE [dbo].[uspLogError];

END CATCH
GO