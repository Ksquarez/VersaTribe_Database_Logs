SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create Proc [dbo].[spPersonDelete]
@Person_Id int
As
Begin
	Delete Person Where Person_Id = @Person_Id
End
GO