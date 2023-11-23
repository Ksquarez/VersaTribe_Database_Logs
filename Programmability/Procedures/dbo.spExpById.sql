SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spExpById]
@Exp_Id int
As
Begin
	Select * from Experience where Exp_id = @Exp_Id
End
GO