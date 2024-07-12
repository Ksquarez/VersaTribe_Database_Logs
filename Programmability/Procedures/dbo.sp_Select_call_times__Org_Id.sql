SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Select_call_times__Org_Id]
(
@Org_Id int
)
As
BEGIN TRY
	SELECT * from call_times Where call_times.Org_Id = @Org_Id;
END TRY
BEGIN CATCH

  EXECUTE [dbo].[uspLogError];

END CATCH
GO