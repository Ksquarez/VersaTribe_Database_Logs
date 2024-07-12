SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE proc [dbo].[sp_OrgServer_ByPk]
(
@Org_Id int,
@Server_Id int
)
AS
BEGIN TRY

	SELECT * FROM OrgServers WHERE Org_Id = @Org_Id AND Server_Id = @Server_Id

END TRY
BEGIN CATCH

  EXECUTE [dbo].[uspLogError];

END CATCH
GO