SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spOrgDept_CRUD]
(
  @Org_Id INT = NULL,
  @Dept_Id INT = NULL,
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,

  /* From Org */
  --@Org_Name NVARCHAR(50) = NULL,

  /* From Department */
  --@Dept_Name NVARCHAR(50) = NULL,
  
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;
	
	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM OrgDept
        WHERE (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@Dept_Id IS NULL OR Dept_Id = @Dept_Id)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@Status IS NULL OR Status = @Status)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
	ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO OrgDept (Org_Id, Dept_Id, TStamp,TOwner,Status)
        VALUES (@Org_Id, @Dept_Id, @TStamp, @TOwner, @Status)

		SELECT * FROM OrgDept WHERE Org_Id = @Org_Id AND Dept_Id = @Dept_Id;

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE OrgDept
        SET Org_Id = ISNULL(@Org_Id,Org_Id),
            Dept_Id = ISNULL(@Dept_Id,Dept_Id),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Status = ISNULL(@Status,Status)
        WHERE Org_Id = @Org_Id AND Dept_Id = @Dept_Id;

		SELECT * FROM OrgDept WHERE Org_Id = @Org_Id AND Dept_Id = @Dept_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM OrgDept
        WHERE Org_Id = @Org_Id AND Dept_Id = @Dept_Id;

		SELECT * FROM OrgDept
        WHERE Org_Id = @Org_Id AND Dept_Id = @Dept_Id;
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO