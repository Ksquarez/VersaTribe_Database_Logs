SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_AttendanceInfo]
    @Person_Id INT,
    @StartDate DATETIME2(7),
    @EndDate DATETIME2(7),
    @Org_Id INT  -- Add Org_Id parameter
AS
BEGIN
    WITH AttendanceCTE AS (
        SELECT 
            a.Login_Date_Time,
            a.Attendence_Type,
            CONVERT(DATE, a.Login_Date_Time) AS LoginDate,
            LEAD(a.Login_Date_Time) OVER (PARTITION BY CONVERT(DATE, a.Login_Date_Time) ORDER BY a.Login_Date_Time) AS NextLoginDateTime,
            LEAD(a.Attendence_Type) OVER (PARTITION BY CONVERT(DATE, a.Login_Date_Time) ORDER BY a.Login_Date_Time) AS NextAttendenceType
        FROM dbo.Attendence a
        INNER JOIN dbo.Person p ON a.Person_Id = p.Person_Id
        WHERE a.Person_Id = @Person_Id
          AND a.Org_Id = @Org_Id  -- Filter by Org_Id
          AND a.Login_Date_Time >= @StartDate
          AND a.Login_Date_Time <= @EndDate
    )
    , TimeSpentCTE AS (
        SELECT 
            LoginDate,
            MIN(CASE WHEN Attendence_Type = 'In' THEN Login_Date_Time END) AS FirstLogin,
            MAX(CASE WHEN Attendence_Type = 'Out' THEN Login_Date_Time END) AS LastLogout,
            SUM(CASE 
                    WHEN Attendence_Type = 'In' AND NextAttendenceType = 'Out' THEN DATEDIFF(SECOND, Login_Date_Time, NextLoginDateTime)
                    ELSE 0 
                END) AS TotalTimeInSeconds
        FROM AttendanceCTE
        GROUP BY LoginDate
    )
    SELECT 
        LoginDate,
        FirstLogin,
        LastLogout,
        CONVERT(VARCHAR, DATEADD(SECOND, TotalTimeInSeconds, 0), 108) AS TotalTime
    FROM TimeSpentCTE
    ORDER BY LoginDate;
END;
GO