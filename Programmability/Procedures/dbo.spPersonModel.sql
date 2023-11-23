SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPersonModel]
(
  @Person_Id INT = NULL,
  @TOwner NVARCHAR(256) = NULL
  --@Training_Name NVARCHAR(50) = NULL,
  --@Description NVARCHAR(MAX) = NULL,
  --@Status INT = NULL,
  --@Start_Date DATE = NULL,
  --@End_Date DATE = NULL,
  --@TStamp DATETIME2(7) = NULL,
  --@TOwner NVARCHAR(256) = NULL,
  --@Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT 
	   P.*,
		(
		SELECT S.* FROM Skills AS S
		INNER JOIN PersonSkill AS PS ON PS.Skill_Id = S.Skill_Id AND PS.Person_Id = P.Person_Id
		FOR JSON AUTO
		) AS Skills,
		(
		SELECT H.* FROM Hobby AS H
		INNER JOIN PersonHobby AS PH ON PH.Hobby_Id = H.Hobby_Id AND PH.Person_Id = P.Person_Id
		FOR JSON AUTO
		) AS Hobby,
		(
		 SELECT EX.*,PE.Job_Title,PE.Exp_months,PE.Start_date,PE.End_Date FROM Experience AS EX
		 INNER JOIN PersonExperience AS PE ON EX.Exp_Id = PE.Exp_Id AND PE.Person_Id = P.Person_Id
		 FOR JSON AUTO
		) AS Experience,
		(
		 SELECT PQ.*,
		 (SELECT CO.*,CourseType.Ctyp_Name FROM Course AS CO
		 INNER JOIN CourseType AS CourseType ON CourseType.CTyp_Id = CO.CTyp_Id
		 WHERE CO.Cou_Id = Q.Cou_Id
		 FOR JSON AUTO
		 ) AS Course,
		 (
		 SELECT I.* FROM Institutes AS I
		 WHERE I.Inst_Id = Q.Inst_Id
		 FOR JSON AUTO
		 ) AS Institutes
		 FROM Qualification AS Q
		 INNER JOIN PersonQualification AS PQ ON Q.QI_Id = PQ.QI_Id AND PQ.Person_Id = P.Person_Id
		 --INNER JOIN Institutes AS I ON I.Inst_Id = Q.Inst_Id
		 --INNER JOIN Course AS CO ON CO.Cou_Id = Q.Cou_Id
		 --INNER JOIN CourseType AS CT ON CT.CTyp_Id = CO.CTyp_Id
		
		 FOR JSON AUTO
		) AS Qualification
		--(
		--SELECT * FROM Experience AS EX
		--WHERE EX.Exp_Id = PE.Exp_Id
		--FOR JSON AUTO
		--) AS Experience,
		--(
		--SELECT CO.*,I.* FROM Qualification AS QU
		--INNER JOIN Course AS CO ON CO.Cou_Id = QU.Cou_Id
		--INNER JOIN Institutes AS I ON I.Inst_Id = QU.Inst_Id
		--INNER JOIN CourseType AS CT ON CO.CTyp_Id = CT.CTyp_Id
		--WHERE QU.QI_Id = PQ.QI_Id
		--FOR JSON AUTO
		--) AS Qualification

        FROM Person AS P
		--INNER JOIN PersonSkill AS PS ON PS.Person_Id = P.Person_Id
		--LEFT JOIN PersonExperience AS PE ON PE.Person_Id = P.Person_Id
		--LEFT JOIN PersonQualification AS PQ ON PQ.Person_Id = P.Person_Id
		--INNER JOIN PersonHobby AS PH ON PH.Person_Id = P.Person_Id
       WHERE (@Person_Id IS NULL OR P.Person_Id = @Person_Id)
            AND (@TOwner IS NULL OR P.TOwner = @TOwner)
			FOR JSON AUTO,INCLUDE_NULL_VALUES
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO