SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create Proc [dbo].[spExpDelete]
@Exp_Id int
As
Begin
		Delete Experience where Exp_Id=@Exp_Id
End
GO