SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [RBAC].[RBAC_Role_Edit_V2]
    @RoleID INT,
    @Resources RBAC.ResourceEditViewModelType_V2  READONLY
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ErrorOccurred BIT = 0;

    BEGIN TRY
        -- Begin a transaction
        BEGIN TRANSACTION;

        -- Delete existing records for the specified RoleID
        DELETE FROM RBAC.ResourcePermission_V2 WHERE RoleID = @RoleID;

        -- Insert new records
        INSERT INTO RBAC.ResourcePermission_V2 (RoleID, ResourceID, Allowed)
        SELECT RoleID, ResourceID, Allowed FROM @Resources WHERE Allowed = 1;

        -- Commit the transaction
        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        -- Set error flag
        SET @ErrorOccurred = 1;

        -- Rollback the transaction if an error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

    END CATCH;

    -- Check if an error occurred
    IF @ErrorOccurred = 1
    BEGIN
        -- Return error message
        SELECT 'Error occurred during transaction. Changes were not saved.' AS Message;
    END
    ELSE
    BEGIN
        -- Return success message
        SELECT 'Changes saved successfully.' AS Message;
    END
END

GO