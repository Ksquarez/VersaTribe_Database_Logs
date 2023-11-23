SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgPersonUpdate]
(
	@Person_Id int,
	@Org_Id int,
	@Dept_Id int,
	@Status int,
	@TStamp datetime2,
	@TOwner nvarchar(256),
	@Request_Status int
)
AS

Begin Try

	SET NOCOUNT OFF;
UPDATE [OrgPerson] 
		SET --[Person_Id] = ISNULL(@Person_Id,Person_Id), 
			--[Org_Id] = ISNULL(@Org_Id,Org_Id),
			--[Dept_Id] = ISNULL(@Dept_Id,Dept_Id), 
			[Status] = ISNULL(@Status,Status), 
			[Request_Status] = ISNULL(@Request_Status,Request_Status),
			[TStamp] = @TStamp, [TOwner] = @TOwner
			WHERE (([Person_Id] = @Person_Id) AND ([Org_Id] = @Org_Id) AND ([Dept_Id] = @Dept_Id));
	
SELECT * FROM OrgPerson WHERE (([Person_Id] = @Person_Id) AND ([Org_Id] = @Org_Id) AND ([Dept_Id] = @Dept_Id))

End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO