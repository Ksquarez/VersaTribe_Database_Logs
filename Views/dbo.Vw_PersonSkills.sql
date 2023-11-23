SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE VIEW [dbo].[Vw_PersonSkills] 
AS

SELECT        PersonSkill.PerSk_Id,Person.FirstName,Person.TOwner,Skills.Skill_Name, Skills.Skill_Field, PersonSkill.Experience, PersonSkill.Status , PersonSkill.TStamp
FROM            Person INNER JOIN
                         PersonSkill ON Person.Person_Id = PersonSkill.Person_Id INNER JOIN
                         Skills ON PersonSkill.Skill_Id = Skills.Skill_Id



GO