SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spOrg_CRUD]
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
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Org
        WHERE (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@Org_Name IS NULL OR Org_Name = @Org_Name)
            AND (@Status IS NULL OR Status = @Status)
			AND (@OrgAdmin_Id IS NULL OR OrgAdmin_Id = @OrgAdmin_Id)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Org(Org_Name , Status, OrgAdmin_Id ,TStamp, TOwner)
        VALUES (@Org_Name , @Status, @OrgAdmin_Id ,@TStamp, @TOwner)

		SELECT * FROM Org WHERE Org_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Org
        SET Org_Name = ISNULL(@Org_Name,Org_Name),
            Status = ISNULL(@Status,Status),
			OrgAdmin_Id = ISNULL(@OrgAdmin_Id,OrgAdmin_Id),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE Org_Id = @Org_Id

		SELECT * FROM Org  WHERE Org_Id = @Org_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Org
        WHERE Org_Id = @Org_Id
		Select * FROM Org Where Org_Id= @Org_Id

    END
	ELSE IF @Action = 'OrgAdmin'
    BEGIN
        SELECT Org_Name
        FROM Org
        WHERE (@OrgAdmin_Id IS NULL OR OrgAdmin_Id = @OrgAdmin_Id)
	END
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH

GO