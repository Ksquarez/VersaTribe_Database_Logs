SET QUOTED_IDENTIFIER, ANSI_NULLS ON
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

 EXECUTE [dbo].[uspLogError];

END CATCH
GO