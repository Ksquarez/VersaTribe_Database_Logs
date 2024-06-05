SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE proc [Session].[spSessionGetPerson]
(
  @Username nvarchar(255)
)
As
BEGIN TRY

/*
    This stored procedure does the following:
    - Get Person Info Of Person
    - Return Person Object
	- Used In Ticket
*/
	
	SELECT p.*,
	dbo.FormatFullName(p.FirstName, p.LastName) AS FullName
	FROM Person p
	WHERE p.TOwner = @Username

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO