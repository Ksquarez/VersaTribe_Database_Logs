SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [RBAC].[GetRoleData]
    @RoleID INT
AS
BEGIN
    SELECT
        r.RoleID,
        r.Name AS RoleName,
        r.Description AS RoleDescription,
        rs.ResourceID,
        rs.Name AS ResourceName,
        rs.Description AS ResourceDescription,
        p.PermissionID,
        p.PermissionName,
        CASE WHEN rp.Allowed IS NOT NULL THEN 1 ELSE 0 END AS Allowed,
		rs.ParentResID
    FROM
        RBAC.Role r
    CROSS JOIN
        RBAC.Resource rs
    CROSS JOIN
        RBAC.Permission p
    LEFT JOIN
        RBAC.ResourcePermission rp ON rp.RoleID = r.RoleID AND rp.ResourceID = rs.ResourceID AND rp.PermissionID = p.PermissionID
    WHERE
        r.RoleID = @RoleID;
END
GO