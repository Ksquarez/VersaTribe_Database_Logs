SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create PROCEDURE [dbo].[spExperienceCri_GetByTrainingId]
    @TrainingId INT
AS
BEGIN TRY
    SELECT
        EC.Id,
        --EC.Training_Id,
        EC.Exp_Id,
		E.Company_Name,
		E.Industry_Field_Name,
        EC.Exp_months,
        EC.Job_Title,
        EC.Status,
        EC.TStamp,
        EC.TOwner,
        EC.Mandatory
    FROM
        Experience_Criteria EC
    INNER JOIN
        Experience E ON EC.Exp_Id = E.Exp_Id
    WHERE
        EC.Training_Id = @TrainingId;

END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH

GO