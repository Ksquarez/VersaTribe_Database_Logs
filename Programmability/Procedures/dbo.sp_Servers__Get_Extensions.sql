SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_Servers__Get_Extensions]
(
  @Srv_Id INT
)

AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT
        E.*
    FROM
        Extensions E
    WHERE
        E.Srv_Id= @Srv_Id;

    
END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO