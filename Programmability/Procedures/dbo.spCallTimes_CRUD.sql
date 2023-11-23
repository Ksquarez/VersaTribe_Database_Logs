SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[spCallTimes_CRUD]
(
  @call_time_id int,
  @call_time_name nvarchar(max),
  @call_time_comments nvarchar(max),
  @ct_default_start smallint,
  @ct_default_stop smallint,
  @ct_sunday_start smallint,
  @ct_sunday_stop smallint,
  @ct_monday_start smallint,
  @ct_monday_stop smallint,
  @ct_tuesday_start smallint,
  @ct_tuesday_stop smallint,
  @ct_wednesday_start smallint,
  @ct_wednesday_stop smallint,
  @ct_thursday_start smallint,
  @ct_thursday_stop smallint,
  @ct_friday_start smallint,
  @ct_friday_stop smallint,
  @ct_saturday_start smallint,
  @ct_saturday_stop smallint,
  @ct_state_call_times nvarchar(max),
  @default_afterhours_filename_override nvarchar(max),
  @sunday_afterhours_filename_override nvarchar(max),
  @monday_afterhours_filename_override nvarchar(max),
  @tuesday_afterhours_filename_override nvarchar(max),
  @wednesday_afterhours_filename_override nvarchar(max),
  @thursday_afterhours_filename_override nvarchar(max),
  @friday_afterhours_filename_override nvarchar(max),
  @saturday_afterhours_filename_override nvarchar(max),
  @user_group nvarchar(max),
  @Org_Id int,
  @ct_holidays nvarchar(max) ,
  @Action VARCHAR(100)
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM call_times
        WHERE   (@call_time_id IS NULL OR call_time_id = @call_time_id)
                AND (@call_time_name IS NULL OR call_time_name = @call_time_name)
                AND (@call_time_comments IS NULL OR call_time_comments = @call_time_comments)
                AND (@ct_default_start IS NULL OR ct_default_start = @ct_default_start)
                AND (@ct_default_stop IS NULL OR ct_default_stop = @ct_default_stop)
                AND (@ct_sunday_start IS NULL OR ct_sunday_start = @ct_sunday_start)
                AND (@ct_sunday_stop IS NULL OR ct_sunday_stop = @ct_sunday_stop)
                AND (@ct_monday_start IS NULL OR ct_monday_start = @ct_monday_start)
                AND (@ct_monday_stop IS NULL OR ct_monday_stop = @ct_monday_stop)
                AND (@ct_tuesday_start IS NULL OR ct_tuesday_start = @ct_tuesday_start)
                AND (@ct_tuesday_stop IS NULL OR ct_tuesday_stop = @ct_tuesday_stop)
                AND (@ct_wednesday_start IS NULL OR ct_wednesday_start = @ct_wednesday_start)
                AND (@ct_wednesday_stop IS NULL OR ct_wednesday_stop = @ct_wednesday_stop)
                AND (@ct_thursday_start IS NULL OR ct_thursday_start = @ct_thursday_start)
                AND (@ct_thursday_stop IS NULL OR ct_thursday_stop = @ct_thursday_stop)
                AND (@ct_friday_start IS NULL OR ct_friday_start = @ct_friday_start)
                AND (@ct_friday_stop IS NULL OR ct_friday_stop = @ct_friday_stop)
                AND (@ct_saturday_start IS NULL OR ct_saturday_start = @ct_saturday_start)
                AND (@ct_saturday_stop IS NULL OR ct_saturday_stop = @ct_saturday_stop)
                AND (@ct_state_call_times IS NULL OR ct_state_call_times = @ct_state_call_times)
                AND (@default_afterhours_filename_override IS NULL OR default_afterhours_filename_override = @default_afterhours_filename_override)
                AND (@sunday_afterhours_filename_override IS NULL OR sunday_afterhours_filename_override = @sunday_afterhours_filename_override)
                AND (@monday_afterhours_filename_override IS NULL OR monday_afterhours_filename_override = @monday_afterhours_filename_override)
                AND (@tuesday_afterhours_filename_override IS NULL OR tuesday_afterhours_filename_override = @tuesday_afterhours_filename_override)
                AND (@wednesday_afterhours_filename_override IS NULL OR wednesday_afterhours_filename_override = @wednesday_afterhours_filename_override)
                AND (@thursday_afterhours_filename_override IS NULL OR thursday_afterhours_filename_override = @thursday_afterhours_filename_override)
                AND (@friday_afterhours_filename_override IS NULL OR friday_afterhours_filename_override = @friday_afterhours_filename_override)
                AND (@saturday_afterhours_filename_override IS NULL OR saturday_afterhours_filename_override = @saturday_afterhours_filename_override)
                AND (@user_group IS NULL OR user_group = @user_group)
                AND (@Org_Id IS NULL OR Org_Id = @Org_Id)
                AND (@ct_holidays IS NULL OR ct_holidays = @ct_holidays);
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO call_times (
            call_time_name, call_time_comments, ct_default_start, ct_default_stop, ct_sunday_start, ct_sunday_stop,
            ct_monday_start, ct_monday_stop, ct_tuesday_start, ct_tuesday_stop, ct_wednesday_start, ct_wednesday_stop,
            ct_thursday_start, ct_thursday_stop, ct_friday_start, ct_friday_stop, ct_saturday_start, ct_saturday_stop,
            ct_state_call_times, default_afterhours_filename_override, sunday_afterhours_filename_override,
            monday_afterhours_filename_override, tuesday_afterhours_filename_override, wednesday_afterhours_filename_override,
            thursday_afterhours_filename_override, friday_afterhours_filename_override, saturday_afterhours_filename_override,
            user_group, Org_Id, ct_holidays
        )
        VALUES (
            @call_time_name, @call_time_comments, @ct_default_start, @ct_default_stop, @ct_sunday_start, @ct_sunday_stop,
            @ct_monday_start, @ct_monday_stop, @ct_tuesday_start, @ct_tuesday_stop, @ct_wednesday_start, @ct_wednesday_stop,
            @ct_thursday_start, @ct_thursday_stop, @ct_friday_start, @ct_friday_stop, @ct_saturday_start, @ct_saturday_stop,
            @ct_state_call_times, @default_afterhours_filename_override, @sunday_afterhours_filename_override,
            @monday_afterhours_filename_override, @tuesday_afterhours_filename_override, @wednesday_afterhours_filename_override,
            @thursday_afterhours_filename_override, @friday_afterhours_filename_override, @saturday_afterhours_filename_override,
            @user_group, @Org_Id, @ct_holidays
        );

        SELECT * FROM call_times WHERE call_time_id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE call_times
        SET
            call_time_name = ISNULL(@call_time_name, call_time_name),
            call_time_comments = ISNULL(@call_time_comments, call_time_comments),
            ct_default_start = ISNULL(@ct_default_start, ct_default_start),
            ct_default_stop = ISNULL(@ct_default_stop, ct_default_stop),
            ct_sunday_start = ISNULL(@ct_sunday_start, ct_sunday_start),
            ct_sunday_stop = ISNULL(@ct_sunday_stop, ct_sunday_stop),
            ct_monday_start = ISNULL(@ct_monday_start, ct_monday_start),
            ct_monday_stop = ISNULL(@ct_monday_stop, ct_monday_stop),
            ct_tuesday_start = ISNULL(@ct_tuesday_start, ct_tuesday_start),
            ct_tuesday_stop = ISNULL(@ct_tuesday_stop, ct_tuesday_stop),
            ct_wednesday_start = ISNULL(@ct_wednesday_start, ct_wednesday_start),
            ct_wednesday_stop = ISNULL(@ct_wednesday_stop, ct_wednesday_stop),
            ct_thursday_start = ISNULL(@ct_thursday_start, ct_thursday_start),
            ct_thursday_stop = ISNULL(@ct_thursday_stop, ct_thursday_stop),
            ct_friday_start = ISNULL(@ct_friday_start, ct_friday_start),
            ct_friday_stop = ISNULL(@ct_friday_stop, ct_friday_stop),
            ct_saturday_start = ISNULL(@ct_saturday_start, ct_saturday_start),
            ct_saturday_stop = ISNULL(@ct_saturday_stop, ct_saturday_stop),
            ct_state_call_times = ISNULL(@ct_state_call_times, ct_state_call_times),
            default_afterhours_filename_override = ISNULL(@default_afterhours_filename_override, default_afterhours_filename_override),
            sunday_afterhours_filename_override = ISNULL(@sunday_afterhours_filename_override, sunday_afterhours_filename_override),
            monday_afterhours_filename_override = ISNULL(@monday_afterhours_filename_override, monday_afterhours_filename_override),
            tuesday_afterhours_filename_override = ISNULL(@tuesday_afterhours_filename_override, tuesday_afterhours_filename_override),
            wednesday_afterhours_filename_override = ISNULL(@wednesday_afterhours_filename_override, wednesday_afterhours_filename_override),
            thursday_afterhours_filename_override = ISNULL(@thursday_afterhours_filename_override, thursday_afterhours_filename_override),
            friday_afterhours_filename_override = ISNULL(@friday_afterhours_filename_override, friday_afterhours_filename_override),
            saturday_afterhours_filename_override = ISNULL(@saturday_afterhours_filename_override, saturday_afterhours_filename_override),
            user_group = ISNULL(@user_group, user_group),
            Org_Id = ISNULL(@Org_Id, Org_Id),
            ct_holidays = ISNULL(@ct_holidays, ct_holidays)
        WHERE call_time_id = @call_time_id;

        SELECT * FROM call_times WHERE call_time_id = @call_time_id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM call_times WHERE call_time_id = @call_time_id;
        SELECT * FROM call_times WHERE call_time_id = @call_time_id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO