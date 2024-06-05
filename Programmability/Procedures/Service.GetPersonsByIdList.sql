SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Service].[GetPersonsByIdList]
    @PersonIds NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SqlQuery NVARCHAR(MAX);

    -- Build the dynamic SQL query
    SET @SqlQuery = '
        SELECT Person_Id, FirstName, LastName, TOwner AS PersonEmail
        FROM Person
        WHERE Person_Id IN (' + @PersonIds + ')
    ';

    -- Execute the dynamic SQL query
    EXEC sp_executesql @SqlQuery;
END;
GO