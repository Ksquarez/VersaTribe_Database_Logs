SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgRole_CRUD]
(
    @Role_Id INT = NULL,
    @Org_Id INT = NULL,
    @Role_Name NVARCHAR(50) = NULL,
    @TStamp DATETIME2(7) = NULL,
    @TOwner NVARCHAR(256) = NULL,
    @Status INT = NULL,
    @Action NVARCHAR(100)
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM OrgRoles
        WHERE (@Role_Id IS NULL OR Role_Id = @Role_Id)
            AND (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@Role_Name IS NULL OR Role_Name = @Role_Name)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
            AND (@Status IS NULL OR Status = @Status)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO OrgRoles (Org_Id, Role_Name, TStamp, TOwner, Status)
        VALUES (@Org_Id, @Role_Name, @TStamp, @TOwner, @Status)

        SELECT * FROM OrgRoles WHERE Role_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE OrgRoles
        SET --Org_Id = ISNULL(@Org_Id, Org_Id),
            Role_Name = ISNULL(@Role_Name, Role_Name),
            TStamp = @TStamp,
            TOwner = @TOwner,
            Status = ISNULL(@Status, Status)
        WHERE Role_Id = @Role_Id

        SELECT * FROM OrgRoles WHERE Role_Id = @Role_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM OrgRoles
        WHERE Role_Id = @Role_Id

        SELECT * FROM OrgRoles WHERE Role_Id = @Role_Id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO