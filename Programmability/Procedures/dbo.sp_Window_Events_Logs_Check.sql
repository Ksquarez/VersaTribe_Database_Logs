SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Window_Events_Logs_Check]
    @Event_Record_Id INT,
    @Person_Id INT,
    @Org_Id INT,
	@Login_Date_Time DATETIME2(7)
AS
BEGIN
    -- Set date part to today
    --DECLARE @TodayStart DATETIME2(7) = CONVERT(DATETIME2(7), CONVERT(DATE, GETDATE()));
    --DECLARE @TodayEnd DATETIME2(7) = DATEADD(DAY, 1, @TodayStart);

    -- Select matching entries
    --SELECT *
    --FROM Window_Events_Logs
    --WHERE Event_Record_Id = @Event_Record_Id
      --AND Person_Id = @Person_Id
      --AND Org_Id = @Org_Id
	  --AND Login_Date_Time = @Login_Date_Time
      --AND TStamp >= @TodayStart
      --AND TStamp < @TodayEnd;
      
      -- Convert @Login_Date_Time to a date-only value
    DECLARE @Login_Date DATE = CAST(@Login_Date_Time AS DATE);

    -- Select matching entries by comparing only the date part
    SELECT *
    FROM Window_Events_Logs
    WHERE Event_Record_Id = @Event_Record_Id
      AND Person_Id = @Person_Id
      AND Org_Id = @Org_Id
      AND CAST(Login_Date_Time AS DATE) = @Login_Date;
END;
GO