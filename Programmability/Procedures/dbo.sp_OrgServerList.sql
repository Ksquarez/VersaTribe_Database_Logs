SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_OrgServerList]
AS
BEGIN
    -- Select servers and related organizations
    SELECT 
        S.Srv_Id AS ServerId,
        S.Name AS ServerName,
        O.Org_Id AS OrgId,		
        O.Org_Name AS OrgName,
		OS.Limit AS Limit
    FROM 
        [CallingDb].[dbo].[Servers] AS S
    INNER JOIN 
        [dbo].[OrgServers] AS OS ON S.Srv_Id = OS.Server_Id
    INNER JOIN 
        [dbo].[Org] AS O ON OS.Org_Id = O.Org_Id
    ORDER BY
        ServerId, OrgId;
END
GO