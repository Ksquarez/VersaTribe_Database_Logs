SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spDepartment_CRUD]
(
  @Dept_Id INT = NULL,
  @Org_Id INT = NULL,
  @Dept_Name NVARCHAR(50) = NULL,
  @Parent_dept_Id INT = NULL,
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
        FROM Department
        WHERE (@Dept_Id IS NULL OR Dept_Id = @Dept_Id)
		    AND (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@Dept_Name IS NULL OR Dept_Name = @Dept_Name)
            AND (@Parent_dept_Id IS NULL OR Parent_dept_Id = @Parent_dept_Id)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Department (Org_Id, Dept_Name, Parent_dept_Id, TStamp,TOwner,Status)
        VALUES (@Org_Id, @Dept_Name, @Parent_dept_Id, @TStamp, @TOwner, @Status)

		SELECT * FROM Department WHERE Dept_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Department
        SET 
		    Org_Id = ISNULL(@Org_Id,Org_Id),
		    Dept_Name = ISNULL(@Dept_Name,Dept_Name),
            Parent_dept_Id = @Parent_dept_Id,
			TStamp = @TStamp,
			TOwner = @TOwner,
			Status = @Status
        WHERE Dept_Id = @Dept_Id

		SELECT * FROM Department WHERE Dept_Id = @Dept_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Department
        WHERE Dept_Id = @Dept_Id

		SELECT * FROM Department
        WHERE Dept_Id = @Dept_Id
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO