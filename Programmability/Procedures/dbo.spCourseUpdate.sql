SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spCourseUpdate]
@Cou_Id int,
@Cou_Name nvarchar(256),
@CTyp_Id int,
@TStamp datetime2(7),
@TOwner nvarchar(256),
@Status int
As
BEGIN TRY
	Update Course 
	Set Cou_Name=ISNULL(@Cou_Name,Cou_Name),
		CTyp_Id=ISNULL(@CTyp_Id,CTyp_Id),
		TStamp=@TStamp,TOwner=@TOwner ,
		Status= ISNULL(@Status,Status)
	Where Cou_Id = @Cou_Id

	SELECT  Cou_Id, Cou_Name, CTyp_Id, TStamp, TOwner, Status FROM Course WHERE Cou_Id = @Cou_Id

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO