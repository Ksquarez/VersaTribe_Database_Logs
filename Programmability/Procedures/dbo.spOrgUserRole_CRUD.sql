SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgUserRole_CRUD]
(
    @Role_Id INT = NULL,
    @Person_Id INT = NULL,
    @TStamp DATETIME2(7) = NULL,
    @TOwner NVARCHAR(256) = NULL,
    @Status INT = NULL,
	@Ext_Id INT = NULL,
	@IsCaller BIT = NULL,
    @Action NVARCHAR(100)
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM OrgUserRole
        WHERE (@Role_Id IS NULL OR Role_Id = @Role_Id)
            AND (@Person_Id IS NULL OR Person_Id = @Person_Id)
			AND (@Ext_Id IS NULL OR Ext_Id = @Ext_Id)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
            AND (@Status IS NULL OR Status = @Status)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO OrgUserRole (Role_Id, Person_Id, TStamp, TOwner, Status, Ext_Id, IsCaller)
        VALUES (@Role_Id, @Person_Id, @TStamp, @TOwner, @Status, @Ext_Id, ISNULL(@IsCaller,0))

        SELECT *
        FROM OrgUserRole
        WHERE Role_Id = @Role_Id AND Person_Id = @Person_Id;
    END
    ELSE IF @Action = 'UPDATE' -- NOT USE
    BEGIN
        UPDATE OrgUserRole
        SET TStamp = ISNULL(@TStamp, TStamp),
            TOwner = ISNULL(@TOwner, TOwner),
            Status = ISNULL(@Status, Status),			
			Ext_Id = CASE When @Ext_Id = -1 THEN NULL
					 When @Ext_Id IS NULL THEN Ext_Id
				 	 Else @Ext_Id
					 END,
			IsCaller = ISNULL(@IsCaller, IsCaller)
					
					--ISNULL(@Ext_Id, Ext_Id),
			
        WHERE Role_Id = @Role_Id AND Person_Id = @Person_Id

        SELECT *
        FROM OrgUserRole
        WHERE Role_Id = @Role_Id AND Person_Id = @Person_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM OrgUserRole
        WHERE Role_Id = @Role_Id AND Person_Id = @Person_Id
		Select * FROM OrgUserRole Where Role_Id= @Role_Id AND Person_Id = @Person_Id
       
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO