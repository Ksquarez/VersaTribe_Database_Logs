SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_ServerGroups__Group_Id]
@Group_Id int
AS
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT *
	From ServerGroups 
	WHERE Group_Id = @Group_Id

 END TRY
BEGIN CATCH

 EXECUTE [dbo].[uspLogError];
END CATCH
GO