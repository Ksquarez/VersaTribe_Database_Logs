SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_OrgServer_create] 
(
    @Org_Id INT,
    @Server_Id INT,
    @Limit INT,
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

	  IF (@TotalOrgServerLimit + @Limit) <= @ServerTrunkLimit
    BEGIN
        -- Insert the new OrgServer record
        INSERT INTO OrgServers (Org_Id, Server_Id, Limit, Status, TStamp, Group_Id)
        VALUES (@Org_Id, @Server_Id, @Limit, @Status, @TStamp, @Group_Id);

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