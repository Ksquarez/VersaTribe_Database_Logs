SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Session].[spSessionGetPersonInfoWithOrgAndIsOrgAdmin__OrgId_UserName]
(
   @Username nvarchar(256),
   @Org_Id INT
)
AS
BEGIN TRY
  
   SELECT
      Org.Org_Id,
      Org.Org_Name,
	  Person.Person_Id,
	  Person.FirstName,
	  Person.LastName,
	  Person.TOwner,
	  CASE WHEN Org.OrgAdmin_Id = @Username THEN CAST(1 as bit)  ELSE CAST(0 as bit) END AS IsAdmin,
	  OrgPerson.IsCaller
   FROM Org
   INNER JOIN OrgPerson ON Org.Org_Id = OrgPerson.Org_Id
   INNER JOIN Person ON Person.Person_Id = OrgPerson.Person_Id
   INNER JOIN Department ON OrgPerson.Dept_Id = Department.Dept_Id
   WHERE OrgPerson.Request_Status = 1 AND Person.TOwner = @Username AND Org.Org_Id = @Org_Id

END TRY
BEGIN CATCH
   INSERT INTO dbo.DB_Errors
      VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO