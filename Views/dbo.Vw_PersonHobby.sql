SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE VIEW [dbo].[Vw_PersonHobby] 
AS

SELECT        PersonHobby.Person_Id, Hobby.Hobby_Id ,Hobby.Name, PersonHobby.Status, PersonHobby.TOwner, PersonHobby.TStamp
FROM            Hobby INNER JOIN
                         PersonHobby ON Hobby.Hobby_Id = PersonHobby.Hobby_Id
	

GO