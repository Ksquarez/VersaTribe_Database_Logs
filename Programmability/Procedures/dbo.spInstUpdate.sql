SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spInstUpdate]
@Inst_Id int,
@Inst_Name nvarchar(50),
@Inst_Type nvarchar(50),
@City nvarchar(50),
@TStamp datetime2(7),
@TOwner nvarchar(256),
@Status int
As
Begin try
	Update Institutes 
	Set Inst_Name=ISNULL(@Inst_Name, Inst_Name), 
		Inst_Type=ISNULL(@Inst_Type,Inst_Type),
		City=ISNULL(@City,City),
		TStamp=@TStamp,           
		TOwner=@TOwner,
		Status= ISNULL(@Status,Status)
	Where Inst_Id = @Inst_Id

SELECT Inst_Id,Inst_Name,Inst_Type,City, TStamp, TOwner,Status FROM Institutes WHERE (Inst_Id= @Inst_Id)

End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO