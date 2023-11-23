SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spPersonQualUpdate]
@PQ_Id int,
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
		Update PersonQualification 
		Set QI_Id=ISNULL(@QI_Id,QI_Id),
			YOP= ISNULL(@YOP,YOP),
			Grade=ISNULL(@Grade,Grade),
			Status=ISNULL(@Status,Status),  
			TStamp=@TStamp,TOwner=@TOwner 
		Where PQ_Id=@PQ_Id

	SELECT PQ_Id, QI_Id, Person_Id, YOP, Grade ,Status , TStamp, TOwner
			FROM PersonQualification WHERE (PQ_Id= @PQ_Id)

End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO