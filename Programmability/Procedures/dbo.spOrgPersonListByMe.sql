SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgPersonListByMe]
(
 @Person_TOwner nvarchar(256),
 @Request_Status INT
)
AS
BEGIN TRY

	SET NOCOUNT ON;
SELECT 
              OrgPerson.Person_Id,
              Person.FirstName,
			  Person.LastName,
			  Person.TOwner AS 'Person.TOwner',
              OrgPerson.Org_Id,
			  Org.Org_Name,
			  OrgPerson.Dept_Id,
			  Department.Dept_Name,
			  OrgPerson.Request_Status,
			  (CASE WHEN OrgPerson.Request_Status= 1 THEN 'APPROVED'
		       WHEN OrgPerson.Request_Status= 0 THEN 'REQUESTED'
		       WHEN OrgPerson.Request_Status=  -1 THEN 'REJECTED'
		       WHEN OrgPerson.Request_Status=  -2 THEN 'REMOVED'
		       ELSE NULL
		       END) AS Request_Status_Name,
			  OrgPerson.Dept_Req,
			  OrgPerson.TStamp, 
			  OrgPerson.TOwner,
			  OrgPerson.Is_Default
FROM          OrgPerson LEFT JOIN Department ON Department.Dept_Id = OrgPerson.Dept_Id 
						 INNER JOIN Person ON OrgPerson.Person_Id = Person.Person_Id 
						 INNER JOIN Org ON Org.Org_Id = OrgPerson.Org_Id
						 WHERE Person.TOwner = @Person_TOwner AND OrgPerson.Request_Status = @Request_Status

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO