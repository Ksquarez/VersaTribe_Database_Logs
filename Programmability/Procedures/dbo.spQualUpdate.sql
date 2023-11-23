SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spQualUpdate]
@QI_Id int,
@Cou_Id int,
@Inst_Id int,
@Towner nvarchar(256),
@TStamp datetime2(7),
@Status int
As
Begin Try
	Update Qualification 
	Set Cou_Id=ISNULL(@Cou_Id, Cou_Id),
		Inst_Id= ISNULL(@Inst_Id ,Inst_Id),
		TOwner=@TOwner ,TStamp=@TStamp,
		Status= ISNULL(@Status,Status)
	Where QI_Id=@QI_Id

	SELECT QI_Id,Cou_Id,Inst_Id, TOwner,TStamp ,Status
		FROM Qualification WHERE (QI_Id= @QI_Id)
End Try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO