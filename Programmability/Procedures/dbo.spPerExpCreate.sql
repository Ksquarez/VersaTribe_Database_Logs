SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spPerExpCreate]
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
	Insert Into PersonExperience(Person_Id,Exp_Id,Exp_months,Job_Title,Start_date,End_Date,TStamp,TOwner,Status)
	values(@Person_Id,@Exp_Id,@Exp_Months,@Job_Title,@Start_date,@End_Date,@TStamp,@TOwner,@Status)

SELECT PerExp_Id,Person_Id,Exp_Id,Exp_months,Job_Title,Start_date,End_Date, TStamp, TOwner, Status FROM
		PersonExperience WHERE (PerExp_Id= SCOPE_IDENTITY())
End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO