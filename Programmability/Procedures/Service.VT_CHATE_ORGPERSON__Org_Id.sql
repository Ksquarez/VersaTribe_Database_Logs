SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Service].[VT_CHATE_ORGPERSON__Org_Id]
    @Org_Id INT
AS
BEGIN 

    SET NOCOUNT ON;

    SELECT 
	p.Person_Id, 
	p.FirstName, 
	p.LastName, 
	p.PersonEmail AS PersonEmail,  
	dbo.FormatFullName(p.FirstName, p.LastName) AS FullName,
	dbo.GenerateAvatarSourceName(p.FirstName, p.LastName) AS AvatarSourceName,
	dbo.GetColorCodeValue(p.FirstName) AS ColorCodeValue
    FROM Org.Vw_OrgPerson p 
    WHERE p.Org_Id = @Org_Id;

END;
GO