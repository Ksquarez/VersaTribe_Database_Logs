SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgDeptListByOrgAdmin]
(
  @TOwner nvarchar(256)
)
AS
BEGIN TRY
	SET NOCOUNT ON;
SELECT        OrgDept.Org_Id,
              Org.Org_Name,
			  OrgDept.Dept_Id,
			  Department.Dept_Name, 
			  OrgDept.TStamp, 
			  OrgDept.TOwner,
			  OrgDept.Status
FROM            Department INNER JOIN
                         OrgDept ON Department.Dept_Id = OrgDept.Dept_Id 
                         INNER JOIN
                         Org ON OrgDept.Org_Id = Org.Org_Id
						 Where Org.OrgAdmin_Id = @TOwner
END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO