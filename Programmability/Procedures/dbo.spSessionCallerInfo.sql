﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE proc [dbo].[spSessionCallerInfo]
(
  @Org_Id INT,
  @Username nvarchar(256)
)
As
BEGIN TRY

    DECLARE @Person_Id INT;

	SELECT @Person_Id = Person_Id FROM Person WHERE TOwner = @Username;

	SELECT Org.Org_Id, Org.Org_Name, OrgPerson.IsCaller, Servers.IP_Address, Extensions.Extension_Srv_Id, 
	Extensions.Secret, Servers.Server_Domain
	FROM Org
	INNER JOIN  OrgPerson ON Org.Org_Id = OrgPerson.Org_Id
	INNER JOIN  Person ON Person.Person_Id = OrgPerson.Person_Id
	INNER JOIN Department ON OrgPerson.Dept_Id = Department.Dept_Id
	LEFT JOIN Extensions ON Extensions.Org_Id = @Org_Id AND Extensions.Person_Id = @Person_Id
	LEFT JOIN Servers ON Servers.Srv_Id = Extensions.Srv_Id
	WHERE OrgPerson.Request_Status = 1 AND OrgPerson.Person_Id = @Person_Id AND OrgPerson.Org_Id = @Org_Id

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO