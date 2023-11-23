SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create Proc [dbo].[spInstDelete]
@Inst_Id int
As
Begin
	Delete Institutes Where Inst_Id= @Inst_Id
End
GO