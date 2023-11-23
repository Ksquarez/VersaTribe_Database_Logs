SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create proc [dbo].[spOrgById]
@Org_Id  int
As
Begin 
	Select * from Org Where Org_Id= @Org_Id
End
GO