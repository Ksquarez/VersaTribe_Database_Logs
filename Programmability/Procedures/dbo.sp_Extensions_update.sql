SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Extensions_update] 
(
    @Extension_Id INT,
    @Extension_Srv_Id NVARCHAR(MAX),
	@UserName NVARCHAR(MAX),
	@Secret NVARCHAR(MAX),
	@Transport NVARCHAR(MAX)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	UPDATE Extensions
	SET UserName = ISNULL(@UserName, UserName),
	    Secret = ISNULL(@Secret, Secret),
		Transport = ISNULL(@Transport, Transport),
		Extension_Srv_Id = ISNULL(@Extension_Srv_Id, Extension_Srv_Id)
    WHERE Extension_Id = @Extension_Id

    SELECT * FROM Extensions WHERE Extension_Id = @Extension_Id;
    

END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO