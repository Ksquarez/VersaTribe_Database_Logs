SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spOrg_JsonModel]
(
  @Org_Id INT = NULL,
  @Org_Name NVARCHAR(50) = NULL,
  @Status INT = NULL,
  @OrgAdmin_Id NVARCHAR(256) = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @PageSize INT = NULL,
  @PageNumber INT = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	-- GET: api/Orgs/

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Org
        WHERE (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@Org_Name IS NULL OR Org_Name = @Org_Name)
            AND (@Status IS NULL OR Status = @Status)
			AND (@OrgAdmin_Id IS NULL OR OrgAdmin_Id = @OrgAdmin_Id)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
	 ELSE IF @Action = 'api/Orgs/GetListPaging'
    BEGIN

        DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
        SELECT 
		Org.*
		FROM
		Org
		ORDER BY Org.Org_Name 
		OFFSET @Offset ROWS
        FETCH NEXT @PageSize ROWS ONLY
		FOR JSON PATH, INCLUDE_NULL_VALUES

    END
	ELSE IF @Action = 'api/Orgs/{Org_Id}/Servers'
    BEGIN

        SELECT Servers.Server_Id, Servers.Server_Name, OrgServers.Limit FROM OrgServers
		INNER JOIN Org  ON Org.Org_Id = OrgServers.Org_Id
		INNER JOIN Servers ON Servers.Server_Id = OrgServers.Server_Id
		WHERE Org.Org_Id = @Org_Id
		FOR JSON PATH, INCLUDE_NULL_VALUES

    END
	
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH

GO