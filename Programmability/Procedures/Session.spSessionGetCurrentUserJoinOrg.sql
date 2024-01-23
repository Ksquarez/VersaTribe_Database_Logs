SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE proc [Session].[spSessionGetCurrentUserJoinOrg]
(
 @Org_Id INT,
 @Person_Id INT
)
As
BEGIN TRY

	SELECT OrgPerson.* FROM Org
	INNER JOIN  OrgPerson ON Org.Org_Id = OrgPerson.Org_Id
	INNER JOIN  Person ON Person.Person_Id = OrgPerson.Person_Id
	INNER JOIN Department ON OrgPerson.Dept_Id = Department.Dept_Id
	WHERE OrgPerson.Request_Status = 1 AND OrgPerson.Person_Id = @Person_Id AND OrgPerson.Org_Id = @Org_Id

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO