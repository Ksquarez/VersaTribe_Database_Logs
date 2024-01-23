SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE proc [Session].[spSessionCallerInfo]
(
  @Org_Id INT,
  @Username nvarchar(256)
)
As
BEGIN TRY

	SELECT VW_Model.Org_Id, VW_Model.Org_Name, VW_Model.IsCaller, Servers.IP_Address, VW_Model.Extension_Srv_Id, 
	VW_Model.Secret, Servers.Server_Domain
	FROM Org.Vw_OrgPerson_Calling_Users AS VW_Model
	LEFT JOIN Servers ON Servers.Srv_Id = VW_Model.Srv_Id
	WHERE  VW_Model.Org_Id = @Org_Id AND VW_Model.PersonEmail = @Username

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO