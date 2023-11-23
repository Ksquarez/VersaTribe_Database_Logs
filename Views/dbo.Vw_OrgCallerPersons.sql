SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [dbo].[Vw_OrgCallerPersons] 
AS

SELECT Org.Org_Id,Org.Org_Name,Person.Person_Id,Person.FirstName,Person.LastName,Person.TOwner AS 'Email',Department.Dept_Name,OrgRoles.Role_Id,OrgRoles.Role_Name,OrgUserRole.IsCaller FROM OrgPerson
INNER JOIN Person ON Person.Person_Id = OrgPerson.Person_Id
INNER JOIN Org ON Org.Org_Id = OrgPerson.Org_Id
INNER JOIN Department ON Department.Dept_Id = OrgPerson.Dept_Id
INNER JOIN	OrgRoles ON OrgRoles.Org_Id = OrgPerson.Org_Id
INNER JOIN OrgUserRole ON OrgUserRole.Role_Id = OrgRoles.Role_Id AND OrgUserRole.Person_Id = OrgPerson.Person_Id
WHERE OrgPerson.Request_Status = 1 AND OrgUserRole.IsCaller = '1'

GO