SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Extensions_update] 
(
    @Extension_Id INT,
    @Org_Id INT,
	@Person_Id INT,
    @Extension_Srv_Id INT,
    @Srv_Id INT,
	@UserName NVARCHAR(MAX),
	@Secret NVARCHAR(MAX),
	@Transport NVARCHAR(MAX)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	BEGIN TRANSACTION;

	UPDATE Extensions
	SET UserName = ISNULL(@UserName, UserName),
	    Secret = ISNULL(@Secret, Secret),
		Transport = ISNULL(@Transport, Transport),
		Org_Id = ISNULL(@Org_Id, Org_Id),
		Person_Id = ISNULL(@Person_Id, Person_Id),
		Extension_Srv_Id = ISNULL(@Extension_Srv_Id, Extension_Srv_Id)
    WHERE Extension_Id = @Extension_Id

    SELECT * FROM Extensions WHERE Extension_Id = @Extension_Id;
    
    COMMIT;

END TRY
BEGIN CATCH

   ROLLBACK;

   EXECUTE [dbo].[uspLogError];

END CATCH
GO