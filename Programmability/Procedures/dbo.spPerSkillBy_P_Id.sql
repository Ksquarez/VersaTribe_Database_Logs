SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPerSkillBy_P_Id]
(
	@Person_Id int
)
AS
BEGIN TRY
	SET NOCOUNT ON;
SELECT        PersonSkill.PerSk_Id,PersonSkill.Person_Id, Skills.Skill_Id , Skills.Skill_Name, Skills.Skill_Field, PersonSkill.Experience, PersonSkill.Status, PersonSkill.TStamp, PersonSkill.TOwner
FROM            PersonSkill INNER JOIN
                         Skills ON PersonSkill.Skill_Id = Skills.Skill_Id
WHERE        (PersonSkill.Person_Id = @Person_Id)

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO