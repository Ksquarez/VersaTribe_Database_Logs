SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spExpCreate]
@Company_Name nvarchar(50),
@Industry_Field_Name nvarchar(50),
@TStamp datetime2(7),
@TOwner nvarchar(256)
As
BEGIN TRY
	Insert Into Experience(Company_Name,Industry_Field_Name,TStamp,TOwner)
		Values(@Company_Name,@Industry_Field_Name,@TStamp,@TOwner)

SELECT Exp_Id, Company_Name,Industry_Field_Name, TStamp, TOwner
	FROM Experience 
		WHERE (Exp_Id= SCOPE_IDENTITY())
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO