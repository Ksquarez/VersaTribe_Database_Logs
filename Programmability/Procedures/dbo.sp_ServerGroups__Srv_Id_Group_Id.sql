SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_ServerGroups__Srv_Id_Group_Id]
(
  @Srv_Id INT,
  @Group_Id INT
)

AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT * FROM ServerGroups WHERE Srv_Id = @Srv_Id AND Group_Id = @Group_Id

    
END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO