﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spSkillsDelete]
(
	@Skill_Id int
)
AS
Begin Try
	SET NOCOUNT OFF;
DELETE FROM [Skills] WHERE (([Skill_Id] = @Skill_Id))
End Try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO