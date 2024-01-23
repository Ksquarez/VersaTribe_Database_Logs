SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- Create stored procedure to get today's logs
CREATE PROCEDURE [dbo].[sp__Logs_GetTodayDatabaseLogs]
(
  @PostTime DATE = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATETIME;
    DECLARE @EndDate DATETIME;

    -- Set the start and end date for today
    SET @StartDate = CAST(GETDATE() AS DATE);
    SET @EndDate = DATEADD(DAY, 1, @StartDate);

    -- Retrieve logs for today
    SELECT *
    FROM [dbo].[DatabaseLog]
    WHERE [PostTime] >= @StartDate
      AND [PostTime] < @EndDate
    ORDER BY [PostTime] DESC;

	-- Retrieve logs for any date
	SELECT *
    FROM [dbo].[DatabaseLog]
    WHERE CONVERT(DATE, PostTime) = @PostTime -- '2023-11-28';
	ORDER BY [PostTime] DESC;

END;
GO