SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [dbo].[Vw_OrgPersonsAll] 
AS

SELECT Org.Org_Id,Org.Org_Name,Person.Person_Id,Person.FirstName,Person.LastName,Person.TOwner AS 'Email',Department.Dept_Name,OrgPerson.Request_Status,OrgPerson.Dept_Req,
(CASE WHEN OrgPerson.Request_Status= 1 THEN 'APPROVED'
		 WHEN OrgPerson.Request_Status= 0 THEN 'REQUESTED'
		 WHEN OrgPerson.Request_Status=  -1 THEN 'REJECTED'
		 WHEN OrgPerson.Request_Status=  -2 THEN 'REMOVED'
		 ELSE NULL
		END) AS Request_Status_Str
 FROM OrgPerson
INNER JOIN Person ON Person.Person_Id = OrgPerson.Person_Id
INNER JOIN Org ON Org.Org_Id = OrgPerson.Org_Id
LEFT JOIN Department ON Department.Dept_Id = OrgPerson.Dept_Id


GO