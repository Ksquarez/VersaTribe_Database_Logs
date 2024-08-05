SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[sp_Window_Events_Logs_Last_Entry] 
@Person_Id  INT,
@Org_Id INT
AS
BEGIN TRY
	SET NOCOUNT ON;
	SELECT Top 1 * from Window_Events_Logs a WHERE a.Person_Id = @Person_Id AND a.Org_Id = @Org_Id
	AND Login_Date_Time IS NOT NULL
	AND Event_Record_Id IS NOT NULL
	--AND 
	--(@Date IS NULL OR Date = @Date) 
	--AND LogOut_Time IS NULL
	Order BY Login_Date_Time DESC , Event_Record_Id desc
   
END TRY
BEGIN CATCH

 EXECUTE [dbo].[uspLogError];
  
END CATCH
GO