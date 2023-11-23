SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create Proc [dbo].[spOrgServer_CRUD]
(
  @Server_Id INT = NULL,
  @Org_Id INT = NULL,
  @Limit INT = NULL, 
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL, 
  @Action NVARCHAR(100)

)   
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM OrgServers
        WHERE (@Server_Id IS NULL OR Server_Id = @Server_Id)
            AND (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@Limit IS NULL OR Limit = @Limit)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
		INSERT INTO OrgServers (Server_Id, Org_Id, Limit,Status,TStamp,TOwner)
        VALUES (@Server_Id, @Org_Id, @Limit, @Status, @TStamp, @TOwner)

		SELECT * FROM OrgServers WHERE Server_Id =  @Server_Id AND Org_Id = @Org_Id

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN

	    UPDATE OrgServers
        SET Server_Id = ISNULL(@Server_Id,Server_Id),
		    Org_Id = ISNULL(@Org_Id,Org_Id),
			Limit = ISNULL(@Limit,Limit),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE Server_Id =  @Server_Id AND Org_Id = @Org_Id

		SELECT * FROM OrgServers WHERE Server_Id =  @Server_Id AND Org_Id = @Org_Id

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM OrgServers
        WHERE Server_Id =  @Server_Id AND Org_Id = @Org_Id

		SELECT * FROM OrgServers
        WHERE Server_Id =  @Server_Id AND Org_Id = @Org_Id
    END
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

  THROW;

END CATCH
GO