SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spExpUpdate]
@Exp_Id int,
@Company_Name nvarchar(50),
@Industry_Field_Name nvarchar(50),
@TStamp datetime2(7),
@TOwner nvarchar(256),
@Status int
As
BEGIN TRY
	--Update Experience set Company_Name=@Company_Name,Industry_Field_Name=@Industry_Field_Name,TStamp=@TStamp,
	--					  TOwner=@TOwner  
	--					  Where Exp_Id=@Exp_Id
	UPDATE Experience
    SET Company_Name = ISNULL(@Company_Name, Company_Name),
        Industry_Field_Name = ISNULL(@Industry_Field_Name, Industry_Field_Name),
        TStamp = @TStamp,
        TOwner = @TOwner,
		Status = ISNULL(@Status, Status)
    WHERE Exp_Id = @Exp_Id;

SELECT Exp_Id, Company_Name,Industry_Field_Name, TStamp, TOwner,Status FROM Experience WHERE (Exp_Id= @Exp_Id)

End Try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO