SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPerHobBy_P_Id]
(
	@Person_Id int
)
AS
	SET NOCOUNT ON;
SELECT        PersonHobby.Person_Id, Hobby.Hobby_Id ,Hobby.Name, PersonHobby.Status, PersonHobby.TOwner, PersonHobby.TStamp
FROM            Hobby INNER JOIN
                         PersonHobby ON Hobby.Hobby_Id = PersonHobby.Hobby_Id
WHERE        (PersonHobby.Person_Id = @Person_Id)
GO