SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE proc [Session].[spPersonExtensionView]
(
  @Org_Id INT,
  @PersonEmail nvarchar(255)
)
As
BEGIN TRY
	
	SELECT Person.* FROM Person
	
	Select * From Extensions

END TRY
BEGIN CATCH

  EXECUTE [dbo].[uspLogError];

END CATCH
GO