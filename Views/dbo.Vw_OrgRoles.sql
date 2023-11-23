SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [dbo].[Vw_OrgRoles] 
AS

SELECT Org.Org_Id, Org.Org_Name, OrgRoles.Role_Id, OrgRoles.Role_Name
FROM Org
INNER JOIN OrgRoles ON OrgRoles.Org_Id = Org.Org_Id


GO