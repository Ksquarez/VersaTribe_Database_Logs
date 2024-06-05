SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Histroy].[Asterisk_Extensions_GetExtensionsPersonListByCdrData]
    @Extension_Srv_Id_List VARCHAR(MAX),
    @Org_Id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Create a temporary table to hold the list of Extension_Srv_Ids
    CREATE TABLE #ExtensionIds (Extension_Srv_Id VARCHAR(50))

    -- Insert the values from the comma-separated string into the temporary table
    INSERT INTO #ExtensionIds (Extension_Srv_Id)
    SELECT value
    FROM STRING_SPLIT(@Extension_Srv_Id_List, ',')

    -- Query to retrieve data based on the provided parameters
    SELECT DISTINCT
        V.PersonName,
        V.Extension_Srv_Id,
        V.Extension_Id
    FROM
        Histroy.Vw_Asterisk_Extensions_Exclude_Duplication AS V
    INNER JOIN #ExtensionIds AS EIds ON V.Extension_Srv_Id = EIds.Extension_Srv_Id
    WHERE
        V.Org_Id = @Org_Id;

    -- Drop the temporary table
    DROP TABLE #ExtensionIds
END
GO