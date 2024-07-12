SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE proc [Session].[spSessionVerifyUserOrgAdminANDOrgPerson]
(
 @Org_Id INT,
 @Person_Id INT
)
As
BEGIN TRY

	SELECT Org.Org_Id, Org.Org_Name, Org.OrgAdmin_Id, Person.Person_Id, Person.TOwner AS 'PersonEmail', Department.Dept_Id, Department.Dept_Name, OrgPerson.IsCaller FROM Org
	INNER JOIN  OrgPerson ON Org.Org_Id = OrgPerson.Org_Id
	INNER JOIN  Person ON Person.Person_Id = OrgPerson.Person_Id
	INNER JOIN Department ON OrgPerson.Dept_Id = Department.Dept_Id
	WHERE OrgPerson.Request_Status = 1 AND Person.Person_Id = @Person_Id AND Org.Org_Id = @Org_Id

END TRY
BEGIN CATCH

  EXECUTE [dbo].[uspLogError];

END CATCH
GO