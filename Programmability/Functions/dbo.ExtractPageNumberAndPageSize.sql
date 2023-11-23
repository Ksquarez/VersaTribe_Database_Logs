SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- Create a function that extracts pageNumber and pageSize from a URL-like string
CREATE FUNCTION [dbo].[ExtractPageNumberAndPageSize](@UrlString NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN
(
    SELECT
        CASE
            WHEN CHARINDEX('pageNumber=', @UrlString) > 0 THEN CAST(SUBSTRING(@UrlString, CHARINDEX('pageNumber=', @UrlString) + LEN('pageNumber='), 
                CASE WHEN CHARINDEX('&', @UrlString, CHARINDEX('pageNumber=', @UrlString)) > 0 THEN CHARINDEX('&', @UrlString, CHARINDEX('pageNumber=', @UrlString)) - (CHARINDEX('pageNumber=', @UrlString) + LEN('pageNumber=')) 
                ELSE LEN(@UrlString) - CHARINDEX('pageNumber=', @UrlString) - LEN('pageNumber=') END) AS INT)
            ELSE NULL
        END AS PageNumber,
        CASE
            WHEN CHARINDEX('pageSize=', @UrlString) > 0 THEN CAST(SUBSTRING(@UrlString, CHARINDEX('pageSize=', @UrlString) + LEN('pageSize='), 
                CASE WHEN CHARINDEX('&', @UrlString, CHARINDEX('pageSize=', @UrlString)) > 0 THEN CHARINDEX('&', @UrlString, CHARINDEX('pageSize=', @UrlString)) - (CHARINDEX('pageSize=', @UrlString) + LEN('pageSize=')) 
                ELSE LEN(@UrlString) - CHARINDEX('pageSize=', @UrlString) - LEN('pageSize=') END) AS INT)
            ELSE NULL
        END AS PageSize
);
GO