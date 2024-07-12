SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Attendence_Last_Entry] @Person_Id  INT,@Org_Id INTASBEGIN TRY	SET NOCOUNT ON;	Select Top 1 * from Attendence a WHERE a.Person_Id = @Person_Id AND a.Org_Id = @Org_Id	--AND 	--(@Date IS NULL OR Date = @Date) 	--AND LogOut_Time IS NULL	Order BY Id desc   END TRYBEGIN CATCH  END CATCH
GO