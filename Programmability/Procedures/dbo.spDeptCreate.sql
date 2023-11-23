SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spDeptCreate]
(
	@Dept_Name nvarchar(50),
	@Parent_dept_Id int,
	@TStamp datetime2,
	@TOwner nvarchar(256)
)
AS
BEGIN TRY
	SET NOCOUNT OFF;
INSERT INTO [Department] ([Dept_Name], [Parent_dept_Id], [TStamp], [TOwner]) VALUES (@Dept_Name, @Parent_dept_Id, @TStamp, @TOwner);
	
SELECT Dept_Id, Dept_Name, Parent_dept_Id, TStamp, TOwner,Status FROM Department WHERE (Dept_Id = SCOPE_IDENTITY())

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO