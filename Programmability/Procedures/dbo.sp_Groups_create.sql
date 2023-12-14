SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Groups_create] 
(
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

	DECLARE @newGroupId INT;


	INSERT INTO Groups (Org_Id, Group_Name, Strategy, TimeOut)
	VALUES (@Org_Id, @Group_Name, @Strategy, @TimeOut);

	SELECT * FROM Groups WHERE Group_Id = SCOPE_IDENTITY();

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