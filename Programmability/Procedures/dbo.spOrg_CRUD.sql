SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[spOrg_CRUD]
(
    @Org_Id INT = NULL,
    @Org_Name NVARCHAR(50) = NULL,
    @Status INT = NULL,
    @OrgAdmin_Id NVARCHAR(256) = NULL,
    @TStamp DATETIME2(7) = NULL,
    @TOwner NVARCHAR(256) = NULL,
    @Action NVARCHAR(100)
)
AS
BEGIN try
    BEGIN TRAN;

    SET nocount ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT*FROM org WHERE 
		( @Org_Id IS NULL OR org_id = @Org_Id ) AND 
		( @Org_Name IS NULL OR org_name = @Org_Name ) AND 
		( @Status IS NULL OR status = @Status ) AND 
		( @OrgAdmin_Id IS NULL OR orgadmin_id = @OrgAdmin_Id ) AND
		( @TStamp IS NULL OR tstamp = @TStamp ) AND 
		( @TOwner IS NULL OR towner = @TOwner )
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO org ( org_name, status, orgadmin_id, tstamp, towner ) VALUES (@Org_Name, @Status, @OrgAdmin_Id, @TStamp, @TOwner)
        -- Retrieve the newly inserted Org_Id using SCOPE_IDENTITY

        DECLARE @NewOrg_Id INT = Scope_identity();


        SELECT * FROM Org WHERE Org_Id = @NewOrg_Id;

    END --ELSE IF @Action = 'UPDATE'
    --   BEGIN
    --       UPDATE Org
    --       SET Org_Name = ISNULL(@Org_Name,Org_Name),
    --           Status = ISNULL(@Status,Status),
    --    OrgAdmin_Id = ISNULL(@OrgAdmin_Id,OrgAdmin_Id),
    --    TStamp = @TStamp,
    --    TOwner = @TOwner
    --       WHERE Org_Id = @Org_Id
    --  SELECT * FROM Org  WHERE Org_Id = @Org_Id;
    --   END
    -- Your existing UPDATE logic
    -- Updated UPDATE logic
    ELSE IF @Action = 'UPDATE'
    BEGIN -- Start a transaction

	UPDATE org

            SET org_name = Isnull(@Org_Name, org_name),
                status = Isnull(@Status, status),
                orgadmin_id = Isnull(@OrgAdmin_Id, orgadmin_id),
                tstamp = @TStamp,
                towner = @TOwner
            WHERE org_id = @Org_Id

			SELECT * FROM ORG WHERE Org_Id = @Org_Id;
       

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM org
        WHERE org_id = @Org_Id

        SELECT *
        FROM org
        WHERE org_id = @Org_Id
    END
    ELSE IF @Action = 'OrgAdmin'
    BEGIN
        SELECT org_name
        FROM org
        WHERE (
                  @OrgAdmin_Id IS NULL
                  OR orgadmin_id = @OrgAdmin_Id
              )
    END
	ELSE IF @Action = 'AUTOCOMPLETE(Org_Name)'
    BEGIN
        SELECT *
        FROM org
        WHERE org_name LIKE @org_name + '%';
    END

    COMMIT;
END try
BEGIN catch
    ROLLBACK;

    INSERT INTO dbo.db_errors
    VALUES
    (Suser_sname(),
     Error_number(),
     Error_state(),
     Error_severity(),
     Error_line(),
     Error_procedure(),
     Error_message(),
     Getdate()
    );
END catch
GO