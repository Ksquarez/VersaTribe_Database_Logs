SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_AllUsersAttendanceInfo]
    @Org_Id INT,
    @StartDate DATETIME2,
    @EndDate DATETIME2
AS
BEGIN
    WITH AttendanceCTE AS (
        SELECT 
            a.Person_Id,
            p.TOwner AS PersonEmail,
            a.Login_Date_Time,
            a.Attendence_Type,
            CONVERT(DATE, a.Login_Date_Time) AS LoginDate,
            LEAD(a.Login_Date_Time) OVER (PARTITION BY a.Person_Id, CONVERT(DATE, a.Login_Date_Time) ORDER BY a.Login_Date_Time) AS NextLoginDateTime,
            LEAD(a.Attendence_Type) OVER (PARTITION BY a.Person_Id, CONVERT(DATE, a.Login_Date_Time) ORDER BY a.Login_Date_Time) AS NextAttendenceType
        FROM Attendence a
        INNER JOIN Person p ON a.Person_Id = p.Person_Id
        WHERE a.Org_Id = @Org_Id
          AND CONVERT(DATE, a.Login_Date_Time) BETWEEN @StartDate AND @EndDate
    ),
    TimeSpentCTE AS (
        SELECT 
            Person_Id,
            PersonEmail,
            LoginDate,
            MIN(CASE WHEN Attendence_Type = 'In' THEN Login_Date_Time END) AS FirstLogin,
            MAX(CASE WHEN Attendence_Type = 'Out' THEN Login_Date_Time END) AS LastLogout,
            SUM(CASE 
                    WHEN Attendence_Type = 'In' AND NextAttendenceType = 'Out' THEN DATEDIFF(SECOND, Login_Date_Time, NextLoginDateTime)
                    ELSE 0 
                END) AS TotalTimeInSeconds
        FROM AttendanceCTE
        GROUP BY Person_Id, PersonEmail, LoginDate
    ),
    AllOrgPersons AS (
        SELECT DISTINCT
            op.Person_Id,
            p.TOwner AS PersonEmail
        FROM OrgPerson op
        INNER JOIN Person p ON op.Person_Id = p.Person_Id
        WHERE op.Org_Id = @Org_Id
          AND op.Request_Status = 1  -- Only include OrgPersons with Request_Status = 1
    )
    SELECT 
        aop.Person_Id,
        aop.PersonEmail,
        tsc.LoginDate,
        tsc.FirstLogin,
        tsc.LastLogout,
        CASE 
            WHEN tsc.TotalTimeInSeconds IS NOT NULL THEN CONVERT(VARCHAR, DATEADD(SECOND, tsc.TotalTimeInSeconds, 0), 108)
            ELSE NULL
        END AS TotalTime
    FROM AllOrgPersons aop
    LEFT JOIN TimeSpentCTE tsc ON aop.Person_Id = tsc.Person_Id AND aop.PersonEmail = tsc.PersonEmail
    ORDER BY aop.Person_Id, tsc.LoginDate;

END;
GO