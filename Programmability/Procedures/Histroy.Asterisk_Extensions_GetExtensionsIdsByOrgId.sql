SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Histroy].[Asterisk_Extensions_GetExtensionsIdsByOrgId]
    @Org_Id INT,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @PageSize INT = NULL,
    @PageNumber INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ExtensionList NVARCHAR(MAX);

    WITH FilteredExtensions AS (
        SELECT Extension_Srv_Id
        FROM [Histroy].[Vw_Asterisk_Extensions]
        WHERE Org_Id = @Org_Id
        AND (@StartDate IS NULL OR DateOrder >= @StartDate)
        AND (@EndDate IS NULL OR DateOrder <= @EndDate)
        GROUP BY Extension_Srv_Id
    )
    SELECT @ExtensionList = COALESCE(@ExtensionList + ',', '') + Extension_Srv_Id
    FROM FilteredExtensions
    ORDER BY Extension_Srv_Id
    OFFSET ISNULL(@PageNumber - 1, 0) * ISNULL(@PageSize, 2147483647) ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    --SET @ExtensionList = STUFF(@ExtensionList, 1, 1, ''); -- Remove leading comma

    SELECT @ExtensionList AS Extension_Srv_Ids;
END;
GO