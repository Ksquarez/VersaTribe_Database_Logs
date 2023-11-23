SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spHobbyUpdate]
@Hobby_Id int,
@Name nvarchar(50),
@TStamp datetime2(7),
@TOwner nvarchar(256),
@Status int
As
Begin Try
	Update Hobby Set Name=@Name, TStamp=@TStamp,TOwner=@TOwner ,Status=@Status
	Where Hobby_Id = @Hobby_Id

SELECT Hobby_Id, Name, TStamp, TOwner,Status FROM Hobby WHERE (Hobby_Id= @Hobby_Id)

End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO