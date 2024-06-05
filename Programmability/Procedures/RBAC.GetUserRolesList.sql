SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [RBAC].[GetUserRolesList]
(
@Org_Id INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT U.Person_Id,
           dbo.FormatFullName(U.FirstName, U.LastName) AS FullName,
		   U.TOwner AS PersonEmail,
           R.RoleID,
		   R.Name,
		   UR.UserRoleId
    FROM RBAC.UserRole UR
    INNER JOIN RBAC.Role R ON UR.RoleID = R.RoleID AND R.Org_Id = @Org_Id
    INNER JOIN Person U ON UR.Person_Id = U.Person_Id
   
END;
GO