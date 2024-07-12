SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_OrgPerson__Pk]
(
 @Org_Id INT,
 @Person_Id INT
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
			  OrgPerson.IsCaller,
			  Extensions.Extension_Id
FROM          OrgPerson LEFT JOIN Department ON Department.Dept_Id = OrgPerson.Dept_Id 
						 INNER JOIN Person ON OrgPerson.Person_Id = Person.Person_Id 
						 INNER JOIN Org ON Org.Org_Id = OrgPerson.Org_Id
						 LEFT JOIN Extensions ON Extensions.Org_Id = @Org_Id AND Extensions.Person_Id = @Person_Id
						 WHERE Org.Org_Id = @Org_Id
						 AND OrgPerson.Request_Status = 1 -- 'APPROVED'
						 AND OrgPerson.Person_Id = @Person_Id

END TRY

BEGIN CATCH

  EXECUTE [dbo].[uspLogError];

END CATCH
GO