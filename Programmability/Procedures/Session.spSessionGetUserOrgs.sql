SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE PROCEDURE [Session].[spSessionGetUserOrgs]
(
   @Username nvarchar(256)
)
AS
BEGIN TRY
  
   SELECT
      'OrgPerson' AS OrgType,
      Org.Org_Name,
      Org.Org_Id,
	  CASE WHEN Org.OrgAdmin_Id = @Username THEN CAST(1 as bit)  ELSE CAST(0 as bit) END AS IsAdmin
   FROM Org
   INNER JOIN OrgPerson ON Org.Org_Id = OrgPerson.Org_Id
   INNER JOIN Person ON Person.Person_Id = OrgPerson.Person_Id
   INNER JOIN Department ON OrgPerson.Dept_Id = Department.Dept_Id
   WHERE OrgPerson.Request_Status = 1 AND Person.TOwner = @Username
END TRY
BEGIN CATCH
   INSERT INTO dbo.DB_Errors
      VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO