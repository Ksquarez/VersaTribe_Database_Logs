SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GroupExtensions_GrpUsers__ByGroupId] 
(
    @Group_Id INT
)
AS
BEGIN TRY
	
	SELECT GrpUsers.Grp_Ext_Id, GrpUsers.Extension_Id, GrpUsers.Group_Id, GrpUsers.Srv_Group_Id,
	Extensions.Person_Id,Extensions.Org_Id,Person.FirstName,Person.LastName,Person.TOwner
	FROM GroupExtensions AS GrpUsers
	INNER JOIN Extensions ON Extensions.Extension_Id = GrpUsers.Extension_Id
	INNER JOIN Person ON Person.Person_Id = Extensions.Person_Id
	INNER JOIN Groups ON Groups.Group_Id = GrpUsers.Group_Id
	WHERE GrpUsers.Group_Id = @Group_Id

END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO