SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Select_ServerGroups__Org_Id_Srv_Id]
(
@Org_Id int,
@context_Id int
)
As
BEGIN TRY

	SELECT ServerGroups.*,
	       Groups.Org_Id, 
		   Groups.Group_Name,
		   Groups.Strategy,
		   Groups.TimeOut,
		   Groups.IsDefault
		   FROM ServerGroups
	INNER JOIN Groups ON Groups.Group_Id = ServerGroups.Group_Id
	Where context_Id = @context_Id AND Groups.Org_Id = @Org_Id;

END TRY
BEGIN CATCH

 EXECUTE [dbo].[uspLogError];

END CATCH
GO