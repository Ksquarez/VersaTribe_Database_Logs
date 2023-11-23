SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spProjectUpdate]
(
	@Project_Name nvarchar(50),
	@Project_Sponser nvarchar(256),
	@Status int,
	@Start_Date date,
	@End_Date date,
	@TStamp datetime2,
	@TOwner nvarchar(256),
	@Project_Id int
)
AS
Begin Try
	SET NOCOUNT OFF;
	UPDATE [Projects] 
	SET [Project_Name] = ISNULL(@Project_Name,Project_Name),
		[Project_Sponser] = ISNULL(@Project_Sponser,Project_Sponser), 
		[Status] = ISNULL(@Status,Status), 
		[Start_Date] = ISNULL(@Start_Date,Start_Date), 
		[End_Date] = ISNULL(@End_Date,End_Date), 
		[TStamp] = @TStamp, [TOwner] = @TOwner 
	WHERE (([Project_Id] = @Project_Id));
	
	SELECT Project_Id, Project_Name, Project_Sponser, Status, Start_Date, End_Date, TStamp, TOwner FROM Projects WHERE (Project_Id = @Project_Id)
End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO