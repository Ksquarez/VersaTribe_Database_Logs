﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spSkillBySkillNameAndSkillField]
@Skill_Name nvarchar(50),
@Skill_Field nvarchar(50)
As
Begin Try
	Select * from Skills Where Skill_Name= @Skill_Name AND Skill_Field Is NULL
End TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO