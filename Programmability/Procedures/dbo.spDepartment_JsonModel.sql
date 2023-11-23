SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spDepartment_JsonModel]
(
  @Dept_Id INT = NULL,
  @Org_Id INT = NULL,
  @Dept_Name NVARCHAR(50) = NULL,
  @Parent_dept_Id INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Status INT = NULL,
  @PageSize INT = NULL,
  @PageNumber INT = NULL,
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
			FOR JSON  AUTO, INCLUDE_NULL_VALUES
    END
	 ELSE IF @Action = 'Department_select_list_by_Org_Id'
	BEGIN
	  SELECT Department.Dept_Id, Department.Dept_Name, Department.Parent_dept_Id
        FROM Department
        WHERE (@Dept_Id IS NULL OR Department.Dept_Id = @Dept_Id)
		    AND (@Org_Id IS NULL OR Department.Org_Id = @Org_Id)
            AND (@Dept_Name IS NULL OR Department.Dept_Name = @Dept_Name)
            AND (@Parent_dept_Id IS NULL OR Department.Parent_dept_Id = @Parent_dept_Id)
			AND (@TStamp IS NULL OR Department.TStamp = @TStamp)
			AND (@TOwner IS NULL OR Department.TOwner = @TOwner)
			AND (@Status IS NULL OR Department.Status = @Status)
			FOR JSON PATH, INCLUDE_NULL_VALUES
	END
	 
	-- api/CourseTypes/GetListPaging/?pageSize=10&pageNumber=1
	 ELSE IF @Action = 'api/Departments/GetListPaging'
    BEGIN
		
		DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
			SELECT Department.* FROM
			Department
			ORDER BY Department.Dept_Name
			OFFSET @Offset ROWS
			FETCH NEXT @PageSize ROWS ONLY
			FOR JSON Auto, INCLUDE_NULL_VALUES

    END
	

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO