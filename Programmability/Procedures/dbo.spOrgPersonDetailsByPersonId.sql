SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgPersonDetailsByPersonId]
(
 @Person_Id INT,
 @Org_Id INT
)
AS
BEGIN TRY

	SET NOCOUNT ON;

         SELECT
             Person.FirstName,
             Person.LastName,
			 Org.Org_Name,
			 Department.Dept_Id,
             Department.Dept_Name,
             OrgPerson.Request_Status,
             OrgPerson.IsCaller,
             OrgPerson.Extension_Id
         FROM
             OrgPerson
             INNER JOIN Person ON Person.Person_Id = OrgPerson.Person_Id
             INNER JOIN Department ON OrgPerson.Dept_Id = Department.Dept_Id
             INNER JOIN Org ON Org.Org_Id = OrgPerson.Org_Id
         WHERE
             OrgPerson.Org_Id = @Org_Id
             AND OrgPerson.Person_Id = @Person_Id

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO