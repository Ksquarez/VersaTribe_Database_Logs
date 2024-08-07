﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GetAttendanceData]
    @PersonId INT,
    @StartDate DATETIME,
    @EndDate DATETIME,
    @Org_Id INT
AS
BEGIN
    SET NOCOUNT ON;

    WITH AttendanceSessions AS (
        SELECT  A.Id,
                A.Person_Id,
                A.Login_Date_Time AS LoginDateTime,
                A.Attendence_Type AS AttendenceType,
				A.Status,
                ROW_NUMBER() OVER (ORDER BY A.Login_Date_Time) AS SessionNumber
        FROM    dbo.Attendence A
        WHERE   A.Person_Id = @PersonId
                AND A.Login_Date_Time >= @StartDate
                AND A.Login_Date_Time <= @EndDate
                AND A.Org_Id = @Org_Id		
    ),
    PairedSessions AS (
        SELECT  ISNULL(InSessions.SessionNumber, OutSessions.SessionNumber) AS SessionNumber,
                InSessions.LoginDateTime AS LoginTime,
                OutSessions.LoginDateTime AS LogoutTime,
				OutSessions.Status AS LogoutStatus,-- Include Status of OutSessions
                DATEDIFF(SECOND, InSessions.LoginDateTime, OutSessions.LoginDateTime) AS TotalSeconds
        FROM    (
                    SELECT  SessionNumber,
                            LoginDateTime
                    FROM    AttendanceSessions
                    WHERE   AttendenceType = 'In'
                ) AS InSessions
        LEFT JOIN (
                    SELECT  SessionNumber,
                            LoginDateTime,
							Status  -- Include Status
                    FROM    AttendanceSessions
                    WHERE   AttendenceType = 'Out'
                ) AS OutSessions ON InSessions.SessionNumber = OutSessions.SessionNumber - 1
    ),
    AllSessions AS (
        SELECT  P.SessionNumber,
                P.LoginTime,
                P.LogoutTime,
				P.LogoutStatus,  -- Include LogoutStatus	
                CONVERT(NVARCHAR(8), DATEADD(SECOND, P.TotalSeconds, 0), 108) AS TotalTimeFormatted
        FROM    PairedSessions P
        WHERE   P.LoginTime IS NOT NULL
    )
    SELECT  AttendanceSessions.Person_Id,
            CONVERT(datetime, AllSessions.LoginTime, 120) AS LoginTime,
            CONVERT(datetime, AllSessions.LogoutTime, 120) AS LogoutTime,
			AllSessions.LogoutStatus AS Status,  -- Use LogoutStatus for final Status
            AllSessions.TotalTimeFormatted AS TotalTime
    FROM    AttendanceSessions
    INNER JOIN AllSessions ON AttendanceSessions.SessionNumber = AllSessions.SessionNumber
    ORDER BY AllSessions.LoginTime;

END;
GO