﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_Servers_ByPk]
(
  @Srv_Id INT
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT * FROM Servers WHERE Srv_Id = @Srv_Id
    
END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO