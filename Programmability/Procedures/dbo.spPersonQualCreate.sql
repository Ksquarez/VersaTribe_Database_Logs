SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spPersonQualCreate]
@QI_Id int,
@Person_Id int,
@YOP date,
@Grade varchar(5),
@Status int,
@TOwner nvarchar(256),
@TStamp datetime2(7)

As
Begin Try

	SET NOCOUNT OFF;

		Insert Into PersonQualification(QI_Id,Person_Id,YOP,Grade,Status,TOwner,TStamp)
			Values(@QI_Id,@Person_Id,@YOP,@Grade,@Status,@TOwner,@TStamp)
	Select PQ_Id, QI_Id, Person_Id, YOP, Grade, Status, TOwner, TStamp FROM PersonQualification WHERE (PQ_Id = SCOPE_IDENTITY())
End try 

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO