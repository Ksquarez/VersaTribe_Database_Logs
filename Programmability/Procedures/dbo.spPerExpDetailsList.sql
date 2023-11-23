SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPerExpDetailsList]
AS
	SET NOCOUNT ON;
SELECT        PersonExperience.PerExp_Id, PersonExperience.Person_Id, PersonExperience.Exp_Id, Experience.Company_Name, Experience.Industry_Field_Name, PersonExperience.Exp_months, PersonExperience.Job_Title, 
                         PersonExperience.Start_date, PersonExperience.End_Date, PersonExperience.TStamp, PersonExperience.TOwner, PersonExperience.Status
FROM            Experience INNER JOIN
                         PersonExperience ON Experience.Exp_Id = PersonExperience.Exp_Id INNER JOIN
                         Person ON PersonExperience.Person_Id = Person.Person_Id
GO