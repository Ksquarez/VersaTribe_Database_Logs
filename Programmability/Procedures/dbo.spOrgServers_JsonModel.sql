SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spOrgServers_JsonModel]
(
  @Org_Id INT = NULL,
  @Server_Id INT = NULL,
  @Limit INT = NULL,
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @PageSize INT = NULL,
  @PageNumber INT = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	-- GET: api/OrgServers

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM OrgServers
        WHERE (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@Server_Id IS NULL OR Server_Id = @Server_Id)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
	 ELSE IF @Action = 'api/OrgServres/GetListPaging'
    BEGIN

        DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
        SELECT 
		OrgServers.*
		FROM
		OrgServers
		ORDER BY OrgServers.Org_Id, OrgServers.Server_Id 
		OFFSET @Offset ROWS
        FETCH NEXT @PageSize ROWS ONLY
		FOR JSON PATH, INCLUDE_NULL_VALUES

    END
	ELSE IF @Action = 'api/Orgs/{Org_Id}/Servers/{Server_Id}'
    BEGIN

	
        SELECT Servers.Server_Id, Servers.Server_Name, OrgServers.Limit FROM OrgServers
		INNER JOIN Org  ON Org.Org_Id = OrgServers.Org_Id
		INNER JOIN Servers ON Servers.Server_Id = OrgServers.Server_Id
		WHERE Org.Org_Id = @Org_Id AND Servers.Server_Id = @Server_Id
		FOR JSON PATH, INCLUDE_NULL_VALUES

    END
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH

GO