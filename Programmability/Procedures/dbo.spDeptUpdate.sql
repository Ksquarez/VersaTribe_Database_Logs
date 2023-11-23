SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spDeptUpdate]
(
	@Dept_Id int,
	@Dept_Name nvarchar(50),
	@Parent_dept_Id int,
	@Status int,
	@TStamp datetime2,
	@TOwner nvarchar(256)
	
)
AS
BEGIN TRY
SET NOCOUNT OFF;
UPDATE [Department] 
	SET [Dept_Name] = ISNULL(@Dept_Name,Dept_Name), 
		[Parent_dept_Id] = ISNULL(@Parent_dept_Id,Parent_dept_Id),
		[Status] = ISNULL(@Status,Status),
		[TStamp] = @TStamp, [TOwner] = @TOwner WHERE (([Dept_Id] = @Dept_Id));
	
SELECT Dept_Id, Dept_Name, Parent_dept_Id, Status, TStamp, TOwner FROM Department WHERE (Dept_Id = @Dept_Id)

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO