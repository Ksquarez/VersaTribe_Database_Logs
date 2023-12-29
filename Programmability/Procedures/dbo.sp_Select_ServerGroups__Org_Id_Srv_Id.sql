SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Select_ServerGroups__Org_Id_Srv_Id]
(
@Org_Id int,
@Srv_Id int
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
	Where Srv_Id = @Srv_Id AND Groups.Org_Id = @Org_Id;

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO