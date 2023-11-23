SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spShiftCreate]
(
	@Shift_Name nvarchar(50),
	@Start_Time time,
	@End_Time time,
	@Status int,
	@TStamp datetime2,
	@TOwner nvarchar(256)
)
AS
Begin Try
	SET NOCOUNT OFF;
	INSERT INTO [Shift] ([Shift_Name], [Start_Time], [End_Time], [Status], [TStamp], [TOwner]) VALUES (@Shift_Name, @Start_Time, @End_Time, @Status, @TStamp, @TOwner);
	
	SELECT Shift_Id, Shift_Name, Start_Time, End_Time, Status, TStamp, TOwner FROM Shift WHERE (Shift_Id = SCOPE_IDENTITY())
End Try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO