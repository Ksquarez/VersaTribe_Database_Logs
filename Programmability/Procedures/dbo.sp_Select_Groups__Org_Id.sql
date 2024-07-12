SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Select_Groups__Org_Id]
(
@Org_Id int
)
As
BEGIN TRY
	SELECT * from Groups Where Org_Id = @Org_Id;
END TRY
BEGIN CATCH

  EXECUTE [dbo].[uspLogError];

END CATCH
GO