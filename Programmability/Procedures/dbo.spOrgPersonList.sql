SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgPersonList]
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
			  Org.OrgAdmin_Id,
			  OrgPerson.Dept_Id,
			  Department.Dept_Name, 
			  Org.Status,
			  OrgPerson.TStamp, 
			  OrgPerson.TOwner
FROM            Department INNER JOIN
                         OrgPerson ON Department.Dept_Id = OrgPerson.Dept_Id INNER JOIN
                         Person ON OrgPerson.Person_Id = Person.Person_Id INNER JOIN
                         OrgDept ON Department.Dept_Id = OrgDept.Dept_Id AND OrgPerson.Org_Id = OrgDept.Org_Id INNER JOIN
						 Org ON Org.Org_Id = OrgDept.Org_Id

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO