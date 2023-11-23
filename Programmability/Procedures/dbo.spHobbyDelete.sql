SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create Proc [dbo].[spHobbyDelete]
@Hobby_Id int
As
Begin
	Delete Hobby Where Hobby_Id = @Hobby_Id
End
GO