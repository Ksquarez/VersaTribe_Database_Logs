SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GetExtensionDetails]
    @Extension_Srv_Id NVARCHAR(MAX),
	@Org_Id INT
AS
BEGIN
    SELECT 
        e.Extension_Srv_Id, 
        (p.FirstName + ' ' + p.LastName) AS FullName, 
        p.TOwner AS PersonEmail
    FROM 
        dbo.Extensions e
    INNER JOIN 
        dbo.Person p ON e.Person_Id = p.Person_Id
    WHERE 
        e.Extension_Srv_Id = @Extension_Srv_Id AND e.Org_Id = @Org_Id;
END
GO