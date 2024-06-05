SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [RBAC].[Permission_Check]
(
@Org_Id INT,
@Person_Id INT,
@RoleID INT,
@Operation NVARCHAR(MAX),
@ResourceName NVARCHAR(MAX)
)
AS
BEGIN
    SET NOCOUNT ON;

	 DECLARE @PermissionCount INT;

    -- First, check if there's a Full-Control permission for the given resource
    SELECT @PermissionCount = COUNT(*)
    FROM RBAC.ResourcePermission RP
    INNER JOIN RBAC.Permission P ON P.PermissionID = RP.PermissionID
    INNER JOIN RBAC.Resource R ON R.ResourceID = RP.ResourceID
    WHERE RP.RoleID = @RoleID
    AND P.Operation = 'Full control'
    AND R.Name = @ResourceName
    AND RP.Allowed = 1;

    -- If Full-Control permission exists, return the data
    IF @PermissionCount > 0
    BEGIN
        SELECT RP.*
        FROM RBAC.ResourcePermission RP
        INNER JOIN RBAC.Permission P ON P.PermissionID = RP.PermissionID
        INNER JOIN RBAC.Resource R ON R.ResourceID = RP.ResourceID
        WHERE RP.RoleID = @RoleID
        AND P.Operation = 'Full control'
        AND R.Name = @ResourceName
        AND RP.Allowed = 1;
    END
    ELSE
    BEGIN
        -- Otherwise, check for the specified operation
        SELECT RP.*
        FROM RBAC.ResourcePermission RP
        INNER JOIN RBAC.Permission P ON P.PermissionID = RP.PermissionID
        INNER JOIN RBAC.Resource R ON R.ResourceID = RP.ResourceID
        WHERE RP.RoleID = @RoleID
        AND P.Operation = @Operation
        AND R.Name = @ResourceName
        AND RP.Allowed = 1;
    END;

 --   SELECT RP.* FROM RBAC.ResourcePermission RP
	--INNER JOIN RBAC.Permission P ON P.PermissionID = RP.PermissionID
	--INNER JOIN RBAC.Resource R ON R.ResourceID = RP.ResourceID
	--WHERE RP.RoleID = @RoleID AND
	--      P.Operation = @Operation AND
	--	  R.Name = @ResourceName AND
	--	  RP.Allowed = 1

END;
GO