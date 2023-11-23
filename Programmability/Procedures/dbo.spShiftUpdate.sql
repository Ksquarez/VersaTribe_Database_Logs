SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spShiftUpdate]
(
	@Shift_Name nvarchar(50),
	@Start_Time time,
	@End_Time time,
	@Status int,
	@TStamp datetime2,
	@TOwner nvarchar(256),
	@Shift_Id int
)
AS
Begin Try
	SET NOCOUNT OFF;
	UPDATE [Shift] 
	SET [Shift_Name] = ISNULL(@Shift_Name,Shift_Name),
		[Start_Time] = ISNULL(@Start_Time,Start_Time),
		[End_Time] = ISNULL(@End_Time,End_Time), 
		[Status] = ISNULL(@Status,Status), 
		[TStamp] = @TStamp, [TOwner] = @TOwner
	WHERE (([Shift_Id] = @Shift_Id));
	
	SELECT Shift_Id, Shift_Name, Start_Time, End_Time, Status, TStamp, TOwner FROM Shift WHERE (Shift_Id = @Shift_Id)
End Try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO