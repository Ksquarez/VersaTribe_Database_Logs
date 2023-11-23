SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spHobbyCreate]
@Name nvarchar(50),
@TStamp datetime2(7),
@TOwner nvarchar(256)
As
Begin Try
	Insert Into Hobby (Name,TStamp,TOwner)
		Values(@Name, @TStamp,@TOwner)

SELECT Hobby_Id, Name, TStamp, TOwner FROM Hobby WHERE (Hobby_Id = SCOPE_IDENTITY())
End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO