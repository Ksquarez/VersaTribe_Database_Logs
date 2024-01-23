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
        SELECT *
        FROM org
        WHERE (
                  @Org_Id IS NULL
                  OR org_id = @Org_Id
              )
              AND (
                      @Org_Name IS NULL
                      OR org_name = @Org_Name
                  )
              AND (
                      @Status IS NULL
                      OR status = @Status
                  )
              AND (
                      @OrgAdmin_Id IS NULL
                      OR orgadmin_id = @OrgAdmin_Id
                  )
              AND (
                      @TStamp IS NULL
                      OR tstamp = @TStamp
                  )
              AND (
                      @TOwner IS NULL
                      OR towner = @TOwner
                  )
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO org
        (
            org_name,
            status,
            orgadmin_id,
            tstamp,
            towner
        )
        VALUES
        (@Org_Name, @Status, @OrgAdmin_Id, @TStamp, @TOwner)
        -- Retrieve the newly inserted Org_Id using SCOPE_IDENTITY

        DECLARE @NewOrg_Id INT = Scope_identity();

        -- Insert into Department with default values
        INSERT INTO department
        (
            org_id,
            dept_name,
            parent_dept_id,
            status,
            tstamp,
            towner,
            is_default
        )
        VALUES
        (@NewOrg_Id, 'Admin', NULL, @Status, @TStamp, @TOwner, 1);

        -- Retrieve the newly inserted Dept_Id using SCOPE_IDENTITY
        DECLARE @NewDept_Id INT = Scope_identity();

        -- Insert into Groups with default values
        --INSERT INTO groups
        --(
        --    org_id,
        --    group_name,
        --    strategy,
        --    timeout,
        --    isdefault
        --)
        --VALUES
        --(@NewOrg_Id, 'Default', NULL, NULL, 1);

        -- Fetch the Person_Id (TOwner) from the Person table based on OrgAdmin_Id
        DECLARE @Person_Id INT;

        SELECT @Person_Id = person_id
        FROM person
        WHERE towner = @OrgAdmin_Id;

        -- Check if Person_Id is NULL (Person not found)
        IF @Person_Id IS NULL
        BEGIN -- Debug information
            PRINT 'Person Profile not found for OrgAdmin_Id ' + @OrgAdmin_Id;

            -- Optionally, you can return an error or take other actions
            RETURN;
        END -- Insert into OrgPerson for OrgAdmin_Id

        IF NOT EXISTS
        (
            SELECT 1
            FROM orgperson
            WHERE person_id = @Person_Id
                  AND org_id = @NewOrg_Id
        )
        BEGIN
            INSERT INTO orgperson
            (
                person_id,
                org_id,
                dept_id,
                status,
                tstamp,
                towner,
                request_status,
                dept_req,
                iscaller,
                extension_id,
                server_id,
                is_default
            )
            VALUES
            (@Person_Id, @NewOrg_Id, @NewDept_Id, @Status, @TStamp, @TOwner, 1, NULL, NULL, NULL, NULL, 1);

            -- Debug information
            PRINT 'OrgPerson created successfully!';
        END
        ELSE
        BEGIN -- Debug information
            PRINT 'OrgPerson already exists for Person_Id ' + CONVERT(NVARCHAR(50), @Person_Id) + ' and Org_Id '
                  + CONVERT(NVARCHAR(50), @NewOrg_Id);
        END
        -- Return the newly inserted Org record along with the Default_Dept_Id

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
        -- Retrieve the existing OrgAdmin_Id (Person_Id) from the Person table
        DECLARE @ExistingPerson_Id INT;
        DECLARE @ExistingPerson_Name NVARCHAR(max);

        SELECT @ExistingPerson_Name = org.orgadmin_id
        FROM org
        WHERE org_id = @Org_Id

        SELECT @ExistingPerson_Id = person.person_id
        FROM person
        WHERE towner = @ExistingPerson_Name

        IF @OrgAdmin_Id = @ExistingPerson_Name
        BEGIN
            UPDATE org
            SET org_name = Isnull(@Org_Name, org_name),
                status = Isnull(@Status, status),
                orgadmin_id = Isnull(@OrgAdmin_Id, orgadmin_id),
                tstamp = @TStamp,
                towner = @TOwner
            WHERE org_id = @Org_Id

            
        END
        ELSE IF @OrgAdmin_Id != @ExistingPerson_Name
        BEGIN
            DECLARE @NewPerson_Id INT;

            SELECT @NewPerson_Id = person_id
            FROM person
            WHERE towner = @OrgAdmin_Id;

			-- update org
            UPDATE org
            SET org_name = Isnull(@Org_Name, org_name),
                status = Isnull(@Status, status),
                orgadmin_id = Isnull(@OrgAdmin_Id, orgadmin_id),
                tstamp = @TStamp,
                towner = @TOwner
            WHERE org_id = @Org_Id

			-- update old person
            UPDATE orgperson
            SET request_status = 1,
                is_default = 0,
                tstamp = @TStamp,
                towner = @TOwner,
                status = 1
            WHERE person_id = @ExistingPerson_Id
                  AND org_id = @Org_Id

            -- check new person create and update
            IF NOT EXISTS
            (
                SELECT 1
                FROM orgperson
                WHERE person_id = @NewPerson_Id
                      AND org_id = @Org_Id
            )
            BEGIN
			 -- Fetch the department ID for the default department ('Admin')
			 
			DECLARE @Get_Dept_Id INT;

                SELECT @Get_Dept_Id = Dept_Id
                FROM department
                WHERE org_id = @Org_Id
                      AND is_default = 1
                      AND dept_name = 'Admin';

                INSERT INTO orgperson
                (
                    person_id,
                    org_id,
                    dept_id,
                    status,
                    tstamp,
                    towner,
                    request_status,
                    is_default
                )
                VALUES
                (@NewPerson_Id, @Org_Id, @Get_Dept_Id, 0, @TStamp, @TOwner, 1, 1);

                -- Debug information
                PRINT 'OrgPerson created successfully!';
            END
            ELSE
            BEGIN
                DECLARE @Dept_Id INT;

                SELECT @Dept_Id= Dept_Id 
                FROM department
                WHERE org_id = @Org_Id
                      AND is_default = 1
                      AND dept_name = 'Admin';

                -- Debug information
                UPDATE orgperson
                SET request_status = 1,
                    is_default = 1,
                    tstamp = @TStamp,
                    towner = @TOwner,
                    status = 1,
                    dept_id = @Dept_Id
                WHERE org_id = @Org_Id
                      AND person_id = @NewPerson_Id;
            END
        END

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