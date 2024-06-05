SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [RBAC].[Permission__In_Service_Check_V2]
(
@Org_Id INT,
@Person_Id INT,
@Url NVARCHAR(MAX)
)
AS
BEGIN
    SET NOCOUNT ON;

	 DECLARE @PermissionCount INT;

	 --DECLARE @Insert_Operations_Data TABLE
  --  (
  --      Operation NVARCHAR(MAX)
  --  );

	 DECLARE @Insert_UserRoles_Data TABLE
    (
        RoleID INT
    );

    -- Split comma-separated values into a table
    --INSERT INTO @Insert_Operations_Data (Operation)
    --SELECT value 
    --FROM STRING_SPLIT(@Operations, ',');

	-- User Roles values in to the table
	INSERT INTO @Insert_UserRoles_Data (RoleID)
	SELECT UR.RoleID
    FROM RBAC.UserRole UR
    INNER JOIN RBAC.Role R ON R.RoleID = UR.RoleID
	WHERE UR.Person_Id = @Person_Id AND UR.Org_Id = @Org_Id;

    -- First, check if there's a Full-Control permission for the given resource
    SELECT @PermissionCount = COUNT(*)
    FROM RBAC.ResourcePermission_V2 RP
    --INNER JOIN RBAC.Permission P ON P.PermissionID = RP.PermissionID
    INNER JOIN RBAC.Resource_V2 R ON R.ResourceID = RP.ResourceID
    WHERE RP.RoleID IN (SELECT R.RoleID FROM @Insert_UserRoles_Data R)
    --AND P.Operation = 'Full control'
    AND R.Url = @Url
    AND RP.Allowed = 1;

    -- If Full-Control permission exists, return the data
    IF @PermissionCount > 0
    BEGIN
        SELECT RP.*
        FROM RBAC.ResourcePermission_V2 RP
        --INNER JOIN RBAC.Permission P ON P.PermissionID = RP.PermissionID
        INNER JOIN RBAC.Resource_V2 R ON R.ResourceID = RP.ResourceID
        WHERE RP.RoleID IN (SELECT R.RoleID FROM @Insert_UserRoles_Data R)
        --AND P.Operation = 'Full control'
        AND R.Url = @Url
        AND RP.Allowed = 1;
    END
    ELSE
    BEGIN
        -- Otherwise, check for the specified operation
        SELECT RP.*
        FROM RBAC.ResourcePermission_V2 RP
        --INNER JOIN RBAC.Permission P ON P.PermissionID = RP.PermissionID
        INNER JOIN RBAC.Resource_V2 R ON R.ResourceID = RP.ResourceID
        WHERE RP.RoleID IN (SELECT R.RoleID FROM @Insert_UserRoles_Data R)
        --AND P.Operation IN (SELECT O.Operation FROM @Insert_Operations_Data O)
        AND R.Url = @Url
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