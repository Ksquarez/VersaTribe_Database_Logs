SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spProjectCreate]
(
	@Project_Name nvarchar(50),
	@Person_Id int,
	@Status int,
	@Start_Date date,
	@End_Date date,
	@TStamp datetime2,
	@TOwner nvarchar(256),
	@Org_Id int,
	@Progress int
)
AS
Begin Try
	SET NOCOUNT OFF;
	INSERT INTO [Projects] ([Project_Name], [Person_Id], [Status], [Start_Date], [End_Date], [TStamp], [TOwner],[Org_Id],[Progress] )
	VALUES (@Project_Name, @Person_Id, @Status, @Start_Date, @End_Date, @TStamp, @TOwner,@Org_Id,@Progress);
	
	SELECT Project_Id, Project_Name, Person_Id, Status, Start_Date, End_Date, TStamp, TOwner ,Org_Id,Progress
	FROM Projects WHERE (Project_Id = SCOPE_IDENTITY())
End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO