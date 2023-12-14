SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Groups_update] 
(
    @Group_Id INT,
    @Org_Id INT,
	@Group_Name NVARCHAR(MAX),
	@Strategy NVARCHAR(MAX),
	@TimeOut INT
	--@Srv_Id INT
	
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	

	BEGIN TRANSACTION;

	 UPDATE Groups
        SET 
            Org_Id = ISNULL(@Org_Id, Org_Id),
            Group_Name = ISNULL(@Group_Name, Group_Name),
            Strategy = ISNULL(@Strategy, Strategy),
            TimeOut = ISNULL(@TimeOut, TimeOut)
        WHERE Group_Id = @Group_Id

		SELECT * FROM Groups WHERE Group_Id = @Group_Id 

		--UPDATE SG
		--SET 
		--Queue_Name = @Group_Name
		--FROM ServerGroups AS SG
		--INNER JOIN OrgServers AS OS ON SG.Srv_Id = OS.Server_Id
  --      WHERE OS.Org_Id = @Org_Id;
		
		
		
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