SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- Create a function that extracts pageSize and pageNumber from the @Action string
CREATE FUNCTION [dbo].[GetPageSizeAndPageNumber] (@Action NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN
(
    SELECT
        CASE
            WHEN CHARINDEX('pageSize=', @Action) > 0 THEN CAST(SUBSTRING(@Action, CHARINDEX('pageSize=', @Action) + LEN('pageSize='), 
                CASE WHEN CHARINDEX('&', @Action, CHARINDEX('pageSize=', @Action)) > 0 THEN CHARINDEX('&', @Action, CHARINDEX('pageSize=', @Action)) - (CHARINDEX('pageSize=', @Action) + LEN('pageSize=')) 
                ELSE LEN(@Action) - CHARINDEX('pageSize=', @Action) - LEN('pageSize=') END) AS INT)
            ELSE NULL
        END AS PageSize,
        CASE
            WHEN CHARINDEX('pageNumber=', @Action) > 0 THEN CAST(SUBSTRING(@Action, CHARINDEX('pageNumber=', @Action) + LEN('pageNumber='), 
                CASE WHEN CHARINDEX('&', @Action, CHARINDEX('pageNumber=', @Action)) > 0 THEN CHARINDEX('&', @Action, CHARINDEX('pageNumber=', @Action)) - (CHARINDEX('pageNumber=', @Action) + LEN('pageNumber=')) 
                ELSE LEN(@Action) - CHARINDEX('pageNumber=', @Action) - LEN('pageNumber=') END) AS INT)
            ELSE NULL
        END AS PageNumber
);
GO