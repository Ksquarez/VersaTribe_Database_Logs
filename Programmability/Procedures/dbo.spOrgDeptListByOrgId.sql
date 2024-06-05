SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgDeptListByOrgId]
(
  @Org_Id INT
)
AS
BEGIN TRY
	SET NOCOUNT ON;

SELECT
    Department.Dept_Id,
    Department.Dept_Name,
    Department.Parent_dept_Id,
    (
        SELECT
            Parent_Department.Dept_Name
        FROM
            Department AS Parent_Department
        Where
            Parent_Department.Dept_Id = Department.Parent_dept_Id
            AND Parent_Department.Org_Id = Org.Org_Id
    ) AS Parent_dept_Name,
    Department.Is_Default
FROM
    Org
    INNER JOIN Department ON Department.Org_Id = Org.Org_Id
	WHERE Department.Org_Id = @Org_Id
						
END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO