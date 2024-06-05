SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [DATA].[sp__GET_SQL_TABLE_DATA]
(
    @SchemaName NVARCHAR(MAX),
    @TableName NVARCHAR(MAX),
    @PageSize INT,
    @PageNumber INT
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    DECLARE @SqlQuery NVARCHAR(MAX);
    DECLARE @Offset INT;

    -- Calculate Offset
    SET @Offset = (@PageNumber - 1) * @PageSize;

    -- Construct the SQL Query
    SET @SqlQuery = '
        DECLARE @TotalCount INT;
        SELECT @TotalCount = COUNT(*) FROM ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + ';

        WITH PaginatedData AS (
            SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
            FROM ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + '
        )
        SELECT * 
        FROM PaginatedData 
        WHERE RowNum BETWEEN ' + CAST(@Offset + 1 AS NVARCHAR(20)) + ' AND ' + CAST(@Offset + @PageSize AS NVARCHAR(20)) + ';

        SELECT @TotalCount AS TotalCount;';

    -- Execute the Dynamic SQL Query
    EXEC sp_executesql @SqlQuery;
END TRY
BEGIN CATCH
    -- Handle errors
    PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
    PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS NVARCHAR(10));
    PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR(10));
    PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
END CATCH
GO