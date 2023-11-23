SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create Proc [dbo].[spHobbySearch]
@Hobby_Id int
As
Begin
	Select * from Hobby Where Hobby_Id = @Hobby_Id
End
GO