SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- Create stored procedure to get today's logs
CREATE PROCEDURE [dbo].[sp_Logs_GetTodayDatabaseLogs]
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
END;
GO