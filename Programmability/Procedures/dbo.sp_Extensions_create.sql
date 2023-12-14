SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Extensions_create] 
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
  --BEGIN TRAN;
	SET NOCOUNT ON;


    DECLARE @ServerTrunkLimit INT

    -- Get the server_trunk_limit for the specified Server_IP
    SELECT @ServerTrunkLimit = server_trunk_limit
    FROM Servers
    WHERE Srv_Id = @Srv_Id;

    -- Check if the current number of extensions for the specified Server_IP exceeds the limit
    IF @ServerTrunkLimit > 0 AND (SELECT COUNT(*) FROM Extensions WHERE Srv_Id = @Srv_Id) < @ServerTrunkLimit
    BEGIN
        -- Insert the new extension record
        INSERT INTO Extensions (Org_Id, Person_Id, Extension_Srv_Id, Srv_Id, UserName, Secret, Transport)
        VALUES (@Org_Id, @Person_Id, @Extension_Srv_Id, @Srv_Id, @UserName, @Secret, @Transport);

		UPDATE OrgPerson
		SET IsCaller = 1
        WHERE Org_Id = @Org_Id AND Person_Id = @Person_Id

		SELECT * FROM Extensions WHERE Extension_Id = SCOPE_IDENTITY();
        
    END

	--COMMIT;
END TRY
BEGIN CATCH

   --ROLLBACK;

   EXECUTE [dbo].[uspLogError];

END CATCH
GO