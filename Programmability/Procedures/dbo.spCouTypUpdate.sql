SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spCouTypUpdate]
@CType_Id int,
@Ctyp_Name nvarchar(50),
@TStamp datetime2(7),
@Towner nvarchar(256)
As
BEGIN TRY
	UPDATE CourseType 
	SET Ctyp_Name=ISNULL(@Ctyp_Name,Ctyp_Name),
	TStamp=@TStamp,TOwner=@TOwner 
	WHERE CTyp_Id=@CType_Id

	SELECT CTyp_Id, Ctyp_Name, TStamp, TOwner,Status FROM CourseType WHERE (CTyp_Id= @CType_Id)
END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO