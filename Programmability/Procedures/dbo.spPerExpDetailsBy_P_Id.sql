SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPerExpDetailsBy_P_Id]
(
	@Person_Id int
)
AS
	SET NOCOUNT ON;
SELECT       PersonExperience.PerExp_Id, PersonExperience.Person_Id, Experience.Exp_Id , Experience.Company_Name, Experience.Industry_Field_Name, PersonExperience.Exp_months, PersonExperience.Job_Title, PersonExperience.Start_date, PersonExperience.End_Date, 
                         PersonExperience.Status, PersonExperience.TStamp, PersonExperience.TOwner
FROM            Experience INNER JOIN
                         PersonExperience ON Experience.Exp_Id = PersonExperience.Exp_Id
WHERE        (PersonExperience.Person_Id = @Person_Id)
GO