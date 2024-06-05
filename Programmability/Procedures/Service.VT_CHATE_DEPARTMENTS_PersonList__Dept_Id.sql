SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Service].[VT_CHATE_DEPARTMENTS_PersonList__Dept_Id]
    @Dept_Id INT
AS
BEGIN TRY
    SET NOCOUNT ON;

	SELECT p.Person_Id, 
	p.FirstName, 
	p.LastName, 
	p.PersonEmail,
	dbo.FormatFullName(p.FirstName, p.LastName) AS FullName,
	dbo.GenerateAvatarSourceName(p.FirstName, p.LastName) AS AvatarSourceName,
	dbo.GetColorCodeValue(p.FirstName) AS ColorCodeValue
	FROM Org.Vw_OrgPerson p 
	WHERE p.Dept_Id = @Dept_Id; 

    
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH


GO