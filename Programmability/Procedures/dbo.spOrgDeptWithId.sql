SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgDeptWithId]
AS
Begin Try
	SET NOCOUNT ON;
SELECT        OrgDept.Org_Id, Department.Dept_Name, OrgDept.TStamp, OrgDept.TOwner
FROM            Department INNER JOIN
                         OrgDept ON Department.Dept_Id = OrgDept.Dept_Id
End Try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO