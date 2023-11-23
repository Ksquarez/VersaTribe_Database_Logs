SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_CreateOrUpdateDeviceStatus]
(
    @device NVARCHAR(255),
    @status NVARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @deviceId BIGINT;

    -- Check if the device already exists
    SELECT @deviceId = id
    FROM dbo.device_status
    WHERE device = @device;

    -- If the device doesn't exist, insert a new record
    IF @deviceId IS NULL
    BEGIN
        INSERT INTO dbo.device_status (device, status)
        VALUES (@device, @status);
    END
    ELSE
    BEGIN
        -- If the device already exists, update its status
        UPDATE dbo.device_status
        SET status = @status
        WHERE id = @deviceId;
    END;
    
    -- Return the ID of the device (newly created or updated)
    SELECT * from device_status Where id = ISNULL(@deviceId, SCOPE_IDENTITY());
END;
GO