SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPersonHobbyList]
AS
Begin Try
	SET NOCOUNT ON;
SELECT        PersonHobby.Person_Id, Hobby.Name, PersonHobby.Status, PersonHobby.TOwner, PersonHobby.TStamp
FROM            PersonHobby INNER JOIN
                         Hobby ON PersonHobby.Hobby_Id = Hobby.Hobby_Id

End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO