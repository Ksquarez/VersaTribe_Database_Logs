SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[spCallTimeHolidays_CRUD]
(
    @holiday_id int = NULL ,
    @holiday_name nvarchar(max)= NULL,
    @holiday_comments nvarchar(max)= NULL,
    @holiday_date date= NULL,
    @holiday_status nvarchar(max) = NULL,
    @ct_default_start smallint = NULL,
    @ct_default_stop smallint = NULL,
    @default_afterhours_filename_override nvarchar(max) = NULL,
    @user_group nvarchar(max) = NULL,
    @Org_Id int = NULL,
    @Action VARCHAR(100)
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM call_time_holidays
        WHERE   (@holiday_id IS NULL OR holiday_id = @holiday_id)
                AND (@holiday_name IS NULL OR holiday_name = @holiday_name)
                AND (@holiday_comments IS NULL OR holiday_comments = @holiday_comments)
                AND (@holiday_date IS NULL OR holiday_date = @holiday_date)
                AND (@holiday_status IS NULL OR holiday_status = @holiday_status)
                AND (@ct_default_start IS NULL OR ct_default_start = @ct_default_start)
                AND (@ct_default_stop IS NULL OR ct_default_stop = @ct_default_stop)
                AND (@default_afterhours_filename_override IS NULL OR default_afterhours_filename_override = @default_afterhours_filename_override)
                AND (@user_group IS NULL OR user_group = @user_group)
                AND (@Org_Id IS NULL OR Org_Id = @Org_Id);
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO call_time_holidays (
            holiday_name, holiday_comments, holiday_date, holiday_status, ct_default_start, ct_default_stop,
            default_afterhours_filename_override, user_group, Org_Id
        )
        VALUES (
            @holiday_name, @holiday_comments, @holiday_date, @holiday_status, @ct_default_start, @ct_default_stop,
            @default_afterhours_filename_override, @user_group, @Org_Id
        );

        SELECT * FROM call_time_holidays WHERE holiday_id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE call_time_holidays
        SET
            holiday_name = ISNULL(@holiday_name, holiday_name),
            holiday_comments = ISNULL(@holiday_comments, holiday_comments),
            holiday_date = ISNULL(@holiday_date, holiday_date),
            holiday_status = ISNULL(@holiday_status, holiday_status),
            ct_default_start = ISNULL(@ct_default_start, ct_default_start),
            ct_default_stop = ISNULL(@ct_default_stop, ct_default_stop),
            default_afterhours_filename_override = ISNULL(@default_afterhours_filename_override, default_afterhours_filename_override),
            user_group = ISNULL(@user_group, user_group),
            Org_Id = ISNULL(@Org_Id, Org_Id)
        WHERE holiday_id = @holiday_id;

        SELECT * FROM call_time_holidays WHERE holiday_id = @holiday_id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM call_time_holidays WHERE holiday_id = @holiday_id;
        SELECT * FROM call_time_holidays WHERE holiday_id = @holiday_id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO