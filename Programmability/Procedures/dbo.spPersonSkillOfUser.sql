SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPersonSkillOfUser]
(
	@TOwner nvarchar(256)
)
AS
BEGIN TRY
	SET NOCOUNT ON;
SELECT        PersonSkill.PerSk_Id,Person.FirstName,Person.TOwner,Skills.Skill_Name, Skills.Skill_Field, PersonSkill.Experience, PersonSkill.Status , PersonSkill.TStamp
FROM            Person INNER JOIN
                         PersonSkill ON Person.Person_Id = PersonSkill.Person_Id INNER JOIN
                         Skills ON PersonSkill.Skill_Id = Skills.Skill_Id
WHERE        (PersonSkill.TOwner = @TOwner)

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO