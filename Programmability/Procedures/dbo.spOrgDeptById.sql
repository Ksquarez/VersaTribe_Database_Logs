SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create proc [dbo].[spOrgDeptById]
@Org_Id  int,
@Dept_Id int
As
Begin 
	Select * from OrgDept Where Org_Id= @Org_Id AND Dept_Id=@Dept_Id
End
GO