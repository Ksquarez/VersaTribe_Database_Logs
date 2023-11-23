SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgPersonCreate]
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
BEGIN TRY

	SET NOCOUNT OFF;
INSERT INTO [OrgPerson] ([Person_Id], [Org_Id], [Dept_Id], [Status], [TStamp], [TOwner],[Request_Status]) VALUES (@Person_Id, @Org_Id, @Dept_Id, @Status, @TStamp, @TOwner, @Request_Status);
	
SELECT Person_Id, Org_Id, Dept_Id, Status, TStamp, TOwner FROM OrgPerson WHERE (([Person_Id] = @Person_Id) AND ([Org_Id] = @Org_Id) AND ([Dept_Id] = @Dept_Id))

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO