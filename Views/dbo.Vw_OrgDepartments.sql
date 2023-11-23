SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [dbo].[Vw_OrgDepartments] 
AS

SELECT Org.Org_Id, Org.Org_Name, Department.Dept_Name, Department.Parent_dept_Id,
  (SELECT Parent_Department.Dept_Name FROM Department AS Parent_Department 
   Where Parent_Department.Dept_Id = Department.Parent_dept_Id AND Parent_Department.Org_Id = Org.Org_Id) AS Parent_dept_Name
FROM Org
INNER JOIN Department ON Department.Org_Id = Org.Org_Id


GO