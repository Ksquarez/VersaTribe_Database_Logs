﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE proc [dbo].[spCouTypByName]
@Ctyp_Name  nvarchar(50)
As
BEGIN TRY
	SELECT * FROM CourseType WHERE Ctyp_Name= @Ctyp_Name
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO