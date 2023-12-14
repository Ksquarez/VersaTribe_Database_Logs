SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_OrgServer_update] 
(
    @Org_Id INT,
    @Server_Id INT,
    @NewLimit INT,
	@Status INT,
	@TStamp DATETIME,
	@TOwner NVARCHAR(256),
	@Group_Id INT
	
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	BEGIN TRANSACTION;

      DECLARE @TotalOrgServerLimit INT
        
      -- Get the total limit assigned to all organizations on the specified Server_Id

      SELECT @TotalOrgServerLimit = ISNULL(SUM(Limit), 0)
      FROM OrgServers
      WHERE Server_Id = @Server_Id;

	   -- Get the server_trunk_limit for the specified Server_Id
      DECLARE @ServerTrunkLimit INT

      SELECT @ServerTrunkLimit = server_trunk_limit
      FROM Servers
      WHERE Srv_Id = @Server_Id;

	  -- Get the org_server current limit
	   -- Calculate the new total OrgServer limit after the update
    DECLARE @NewTotalOrgServerLimit INT
    SET @NewTotalOrgServerLimit = (@TotalOrgServerLimit - (SELECT Limit FROM OrgServers WHERE Org_Id = @Org_Id AND Server_Id = @Server_Id)) + @NewLimit;


	  IF @NewTotalOrgServerLimit <= @ServerTrunkLimit
    BEGIN

        -- Update the OrgServer record
        UPDATE OrgServers
        SET Limit = @NewLimit,
		    TStamp = @TStamp,
			TOwner = @TOwner,
            Group_Id = ISNULL(@Group_Id, Group_Id)
        WHERE Org_Id = @Org_Id AND Server_Id = @Server_Id;

        -- You can add additional logic or error handling here if needed

        SELECT * FROM OrgServers WHERE Org_Id = @Org_Id AND Server_Id = @Server_Id

    END

	 COMMIT;

END TRY
BEGIN CATCH

  ROLLBACK;

  EXECUTE [dbo].[uspLogError];

END CATCH
GO