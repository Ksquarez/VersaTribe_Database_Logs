SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spQualCreate]
@Cou_Id int,
@Inst_Id int,
@Towner nvarchar(256),
@TStamp datetime2(7)
As
Begin Try
	Insert Into Qualification(Cou_Id,Inst_Id,TOwner,TStamp)
		Values(@Cou_Id,@Inst_Id,@Towner,@TStamp)

	SELECT QI_Id,Cou_Id,Inst_Id, TOwner,TStamp 
		FROM Qualification WHERE (QI_Id= SCOPE_IDENTITY())
End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO