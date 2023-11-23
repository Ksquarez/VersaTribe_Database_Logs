SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spPerExpUpdate]
@PerExp_Id int,
@Person_Id int,
@Exp_Id int,
@Exp_Months int,
@Job_Title nvarchar(50),
@Start_date date,
@End_Date date,
@TStamp datetime2(7),
@TOwner nvarchar(256),
@Status int
As
Begin Try
	Update PersonExperience Set Person_Id=ISNULL(@Person_Id,Person_Id),
								Exp_Id=ISNULL(@Exp_Id,Exp_Id),
								Exp_months=ISNULL(@Exp_Months,Exp_Months),
								Job_Title=ISNULL(@Job_Title, Job_Title),
								Start_date=ISNULL(@Start_date,Start_date),
								End_Date=ISNULL(@End_Date,End_Date),
								TStamp=@TStamp,TOwner=@TOwner,
								Status=ISNULL(@Status,Status)
							Where PerExp_Id=@PerExp_Id

SELECT PerExp_Id,Person_Id,Exp_Id,Exp_months,Job_Title,Start_date,End_Date, TStamp, TOwner, Status FROM 
		PersonExperience WHERE (PerExp_Id= @PerExp_Id)
End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO