﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp__Mst_ResultMessages__Result]
(
  @Result int
)
As
BEGIN TRY

    SET NOCOUNT ON;

	SELECT Result, Message FROM Mst_ResultMessages WHERE Result = @Result;

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO