SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Select_Extensions__Org_Id]
(
@Org_Id int
)
AS
BEGIN TRY

	SELECT Extensions.*, Person.FirstName, Person.LastName, Person.TOwner FROM Extensions 
	INNER JOIN Person ON Person.Person_Id = Extensions.Person_Id
	WHERE Org_Id = @Org_Id;

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO