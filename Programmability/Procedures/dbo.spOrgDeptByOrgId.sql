SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgDeptByOrgId]
    @OrgId INT
AS
BEGIN
    SET NOCOUNT ON;
    
 --   Select [Dept_Id] from OrgDept
	--INNER JOIN Department D As 
 --   WHERE [Org_Id] = @OrgId;
	SELECT OD.[Dept_Id], D.[Dept_Name]
    FROM [dbo].[OrgDept] OD
    INNER JOIN [Department] D ON OD.[Dept_Id] = D.[Dept_Id]
    WHERE OD.[Org_Id] = @OrgId;
END;
GO