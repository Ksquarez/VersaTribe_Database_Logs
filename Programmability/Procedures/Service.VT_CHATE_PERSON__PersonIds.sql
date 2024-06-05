SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Service].[VT_CHATE_PERSON__PersonIds]
    @PersonIds NVARCHAR(MAX)
AS
BEGIN 

    SET NOCOUNT ON;

    SELECT 
	p.Person_Id, 
	p.FirstName, 
	p.LastName, 
	p.TOwner AS PersonEmail,  
	dbo.FormatFullName(p.FirstName, p.LastName) AS FullName,
	dbo.GenerateAvatarSourceName(p.FirstName, p.LastName) AS AvatarSourceName,
	dbo.GetColorCodeValue(p.FirstName) AS ColorCodeValue	
    FROM Person p
    WHERE CHARINDEX(',' + CAST(Person_Id AS NVARCHAR(MAX)) + ',', ',' + @PersonIds + ',') > 0;

END;
GO