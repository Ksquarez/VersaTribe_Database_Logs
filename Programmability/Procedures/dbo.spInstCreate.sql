SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spInstCreate]
@Inst_Name nvarchar(50),
@Inst_Type nvarchar(50),
@City nvarchar(50),
@TStamp datetime2(7),
@TOwner nvarchar(256),
@Status int
As
BEGIN TRY
	Insert Into Institutes(Inst_Name,Inst_Type,City,TStamp,TOwner,Status)
		Values(@Inst_Name,@Inst_Type,@City, @TStamp,@TOwner,@Status)

SELECT Inst_Id, Inst_Name,Inst_Type,City, TStamp, TOwner,Status FROM Institutes WHERE (Inst_Id= SCOPE_IDENTITY())
END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO