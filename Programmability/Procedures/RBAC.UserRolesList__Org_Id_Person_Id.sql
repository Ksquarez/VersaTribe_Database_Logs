SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [RBAC].[UserRolesList__Org_Id_Person_Id]
(
@Org_Id INT,
@Person_Id INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT UR.UserRoleId, UR.RoleID, R.Name
    FROM RBAC.UserRole UR
    INNER JOIN RBAC.Role R ON R.RoleID = UR.RoleID
	WHERE UR.Person_Id = @Person_Id AND UR.Org_Id = @Org_Id;
    
END;
GO