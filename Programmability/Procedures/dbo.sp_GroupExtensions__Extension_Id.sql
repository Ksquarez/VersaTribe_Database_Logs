SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GroupExtensions__Extension_Id]
@Extension_Id int
AS
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT E.Extension_Id ,
		   G.*, 
		   GE.Srv_Group_Id,
		   GE.Grp_Ext_Id
	From GroupExtensions as GE
	INNER JOIN Groups as G ON G.Group_Id = GE.Group_Id
	INNER JOIN Extensions as E ON GE.Extension_Id = E.Extension_Id
	WHERE E.Extension_Id = @Extension_Id

 END TRY
BEGIN CATCH

 EXECUTE [dbo].[uspLogError];
END CATCH
GO