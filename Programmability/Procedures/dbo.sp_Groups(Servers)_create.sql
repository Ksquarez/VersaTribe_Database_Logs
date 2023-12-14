SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Groups(Servers)_create] 
(
    @Org_Id INT,
	@Group_Name NVARCHAR(MAX),
	--@Strategy NVARCHAR(MAX),
	--@TimOut NVARCHAR(MAX),
	@GroupId INT
	--@Srv_Id INT
	
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	BEGIN TRANSACTION;

	--DECLARE @newGroupId INT;


	--INSERT INTO Groups (Org_Id, Group_Name, Strategy, TimeOut)
	--VALUES (@Org_Id, @Group_Name, @Strategy, @TimOut);

	--SET @newGroupId = SCOPE_IDENTITY();

	--DECLARE @SequentialNumber INT;
	DECLARE @InsertedServerGroups TABLE (
	    Srv_Group_Id INT,
        Srv_Id INT,
        Group_Id INT,
        Queue_Id INT,
        Queue_Name NVARCHAR(MAX)
    );
	
	INSERT INTO
        ServerGroups (Srv_Id, Group_Id, Queue_Id, Queue_Name) OUTPUT 
		inserted.Srv_Group_Id,
		inserted.Srv_Id,
        inserted.Group_Id,
        inserted.Queue_Id,
        inserted.Queue_Name INTO @InsertedServerGroups
    SELECT
        OS.Server_Id,
        @GroupId,
        dbo.fn_GenerateGroupSequentialNumber(OS.Server_Id),
        @Group_Name
    FROM
        OrgServers AS OS
    WHERE
        Org_Id = @Org_Id;
    
     -- Select the inserted records
    SELECT Srv_Group_Id, 
	       InsertedServerGroups.Srv_Id, 
		   InsertedServerGroups.Group_Id, 
		   Queue_Id, 
		   Queue_Name,
		   Servers.IP_Address,
		   Groups.Group_Name,
		   Groups.Strategy,
		   Groups.TimeOut
    FROM @InsertedServerGroups AS InsertedServerGroups
	INNER JOIN Servers ON Servers.Srv_Id = InsertedServerGroups.Srv_Id
	INNER JOIN Groups ON Groups.Group_Id = InsertedServerGroups.Group_Id

	COMMIT;

END TRY
BEGIN CATCH

   ROLLBACK;

   EXECUTE [dbo].[uspLogError];

END CATCH
GO