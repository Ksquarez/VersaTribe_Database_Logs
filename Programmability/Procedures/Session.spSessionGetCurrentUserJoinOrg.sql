SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE proc [Session].[spSessionGetCurrentUserJoinOrg]
(
 @Org_Id INT,
 @Person_Id INT
)
As
BEGIN TRY

/*
    This stored procedure does the following:
    - Get All the Join Orgs InFo Of That Person 
    - Return OrgPerson Complete Object
    */

	SELECT OrgPerson.* FROM Org
	INNER JOIN  OrgPerson ON Org.Org_Id = OrgPerson.Org_Id
	INNER JOIN  Person ON Person.Person_Id = OrgPerson.Person_Id
	INNER JOIN Department ON OrgPerson.Dept_Id = Department.Dept_Id
	WHERE OrgPerson.Request_Status = 1 AND OrgPerson.Person_Id = @Person_Id AND OrgPerson.Org_Id = @Org_Id

END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO