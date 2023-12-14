SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Groups_delete] 
(
    @Group_Id INT
    --@Org_Id INT
	--@Srv_Id INT
	
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	

	BEGIN TRANSACTION;

	--DELETE FROM ServerGroups
	--  WHERE Group_Id = @Group_Id

	  DELETE FROM Groups
        WHERE Group_Id = @Group_Id
		
		
	--SET @newGroupId = SCOPE_IDENTITY();

	--DECLARE @SequentialNumber INT;
	
	--INSERT INTO ServerGroups (Srv_Id, Group_Id, Queue_Id, Queue_Name)
 --   SELECT OS.Server_Id, @newGroupId, dbo.fn_GenerateGroupSequentialNumber(OS.Server_Id), @Group_Name 
 --   FROM OrgServers AS OS 
 --   WHERE Org_Id = @Org_Id;

    

	 COMMIT;

END TRY
BEGIN CATCH

   ROLLBACK;

   EXECUTE [dbo].[uspLogError];

END CATCH
GO