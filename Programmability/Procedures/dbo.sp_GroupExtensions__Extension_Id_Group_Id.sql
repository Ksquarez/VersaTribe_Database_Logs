SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GroupExtensions__Extension_Id_Group_Id]
@Extension_Id int,
@Group_Id int
AS
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT *
	From GroupExtensions 
	WHERE Extension_Id = @Extension_Id AND Group_Id = @Group_Id

 END TRY
BEGIN CATCH

 EXECUTE [dbo].[uspLogError];
END CATCH
GO