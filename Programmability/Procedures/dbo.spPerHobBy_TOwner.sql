SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create PROCEDURE [dbo].[spPerHobBy_TOwner]
(
	@TOwner nvarchar(256)
)
AS
	SET NOCOUNT ON;
SELECT        PersonHobby.Person_Id, Hobby.Hobby_Id ,Hobby.Name, PersonHobby.Status, PersonHobby.TOwner, PersonHobby.TStamp
FROM            Hobby INNER JOIN
                         PersonHobby ON Hobby.Hobby_Id = PersonHobby.Hobby_Id
WHERE        (PersonHobby.TOwner = @TOwner)
GO