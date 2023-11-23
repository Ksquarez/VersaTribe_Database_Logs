SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [dbo].[Vw_OrgUserRoles] 
AS

SELECT Org.Org_Id, Org.Org_Name, OrgRoles.Role_Id, OrgRoles.Role_Name, Person.Person_Id, Person.FirstName, Person.LastName, Person.TOwner AS 'Email', OrgUserRole.IsCaller
FROM Org
INNER JOIN OrgRoles ON OrgRoles.Org_Id = Org.Org_Id
INNER JOIN OrgUserRole ON OrgUserRole.Role_Id = OrgRoles.Role_Id
INNER JOIN Person ON OrgUserRole.Person_Id = Person.Person_Id


GO