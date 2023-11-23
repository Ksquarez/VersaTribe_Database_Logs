SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spCouTypCreate]
@Ctype_Name nvarchar(50),
@TStamp datetime2(7),
@Towner nvarchar(256)
As
BEGIN TRY
	INSERT INTO CourseType(Ctyp_Name,TStamp,TOwner)
		VALUES(@Ctype_Name,@TStamp,@Towner)

		SELECT CTyp_Id, Ctyp_Name , TStamp, TOwner,Status FROM CourseType WHERE (CTyp_Id = SCOPE_IDENTITY())
END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO