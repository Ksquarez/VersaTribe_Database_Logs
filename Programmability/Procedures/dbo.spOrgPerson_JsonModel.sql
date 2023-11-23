SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spOrgPerson_JsonModel]
(
  @Person_Id INT = NULL,
  @Org_Id INT = NULL,
  @Dept_Id INT = NULL,
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Request_Status INT = NULL,
  @Dept_Req nvarchar(50) = NULL,
  @PageSize INT = NULL,
  @PageNumber INT = NULL,
  @Action NVARCHAR(100)
)   
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM OrgPerson
        WHERE (@Person_Id IS NULL OR Person_Id = @Person_Id)
            AND (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@Dept_Id IS NULL OR Dept_Id = @Dept_Id)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Request_Status IS NULL OR Request_Status = @Request_Status)
			AND (@Dept_Req IS NULL OR Dept_Req = @Dept_Req)
			FOR JSON  AUTO, INCLUDE_NULL_VALUES
    END
	--ELSE IF @Action = 'api/OrgPersons/Person/{Person_Id}/Orgs'
 --   BEGIN
 --       SELECT Org.Org_Id,Org.Org_Name,
	--	(CASE WHEN OrgPerson.Request_Status= 1 THEN 'APPROVED'
	--	 WHEN OrgPerson.Request_Status= 0 THEN 'REQUESTED'
	--	 WHEN OrgPerson.Request_Status=  -1 THEN 'REJECTED'
	--	 WHEN OrgPerson.Request_Status=  -2 THEN 'REMOVED'
	--	 ELSE NULL
	--	END) AS Status_Str
 --       FROM OrgPerson
	--	INNER JOIN Org ON Org.Org_Id = OrgPerson.Org_Id
 --       WHERE OrgPerson.Person_Id = @Person_Id
	--	FOR JSON  PATH, INCLUDE_NULL_VALUES
	--END
	--ELSE IF @Action = 'api/OrgPersons/Org/{Org_Id}/Person/Requests'
 --   BEGIN
 --       SELECT OrgPerson.Org_Id,
	--	(CASE WHEN OrgPerson.Request_Status= 1 THEN 'APPROVED'
	--	 WHEN OrgPerson.Request_Status= 0 THEN 'REQUESTED'
	--	 WHEN OrgPerson.Request_Status= -1 THEN 'REJECTED'
	--	 WHEN OrgPerson.Request_Status= -2 THEN 'REMOVED'
	--	 ELSE NULL
	--	END) AS Status_Str,
	--	OrgPerson.Dept_Id,
	--	OrgPerson.Person_Id,
	--	OrgPerson.Request_Status,
	--	OrgPerson.Dept_Req,
	--	Org.Org_Name AS 'Org.Org_Name',
	--	Department.Dept_Name AS 'Department.Dept_Name',
	--	Person.TOwner AS 'Person.TOwner'
 --       FROM OrgPerson
	--	INNER JOIN Org ON Org.Org_Id = OrgPerson.Org_Id
	--	LEFT JOIN Department ON Department.Dept_Id = OrgPerson.Dept_Id
	--	INNER JOIN Person ON Person.Person_Id = OrgPerson.Person_Id
 --       WHERE OrgPerson.Org_Id = @Org_Id            
	--    FOR JSON  PATH, INCLUDE_NULL_VALUES
	--END

	-- api/OrgPerson/GetListPaging/?pageSize=10&pageNumber=1
	ELSE IF @Action = 'api/OrgPerson/GetListPaging'
    BEGIN		
		DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
			SELECT OrgPerson.*, Org.Org_Name , Person.TOwner AS 'Person.TOwner' FROM
			OrgPerson
			Inner join Org ON OrgPerson.Org_Id = Org.Org_Id
			Inner Join Person ON OrgPerson.Person_Id = Person.Person_Id 
			ORDER BY OrgPerson.Person_Id
			OFFSET @Offset ROWS
			FETCH NEXT @PageSize ROWS ONLY
			FOR JSON Path, INCLUDE_NULL_VALUES

			
    END

	--ELSE IF @Action = 'api/OrgPersons/MyJoinOrgs'
	--BEGIN
	--  SELECT Org.Org_Id,
	--         Org.Org_Name,
	--		 Org.OrgAdmin_Id,
	--		 Person.Person_Id,
	--		 Person.FirstName,
	--		 Person.LastName,
	--		 Person.TOwner AS 'Email',
	--		 Department.Dept_Name,
	--		 OrgPerson.Request_Status,
	--		 OrgPerson.Dept_Req,
 --           (CASE WHEN OrgPerson.Request_Status= 1 THEN 'APPROVED'
	--	     WHEN OrgPerson.Request_Status= 0 THEN 'REQUESTED'
	--	     WHEN OrgPerson.Request_Status=  -1 THEN 'REJECTED'
	--	     WHEN OrgPerson.Request_Status=  -2 THEN 'REMOVED'
	--	     ELSE NULL
	--	     END) AS Request_Status_Str
 --      FROM OrgPerson
 --      INNER JOIN Person ON Person.Person_Id = OrgPerson.Person_Id
 --      INNER JOIN Org ON Org.Org_Id = OrgPerson.Org_Id
 --      LEFT JOIN Department ON Department.Dept_Id = OrgPerson.Dept_Id
 --      WHERE (@Request_Status IS NULL OR Request_Status = @Request_Status) AND OrgPerson.Person_Id = @Person_Id
	--   ORDER BY Org.Org_Name
	--   FOR JSON Path, INCLUDE_NULL_VALUES
	--END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO