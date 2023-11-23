SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create PROCEDURE [dbo].[spQualificationCri_GetByTrainingId]
    @TrainingId INT
AS
BEGIN TRY
    SELECT
        QC.Id AS Qualification_Criteria_Id,
        QC.Training_Id,
        QC.Cou_Id,
        C.Cou_Name,
        QC.Status,
        QC.TStamp,
        QC.TOwner,
        QC.Mandatory
    FROM
        Qualification_Criteria QC
    INNER JOIN
        Course C ON QC.Cou_Id = C.Cou_Id
    WHERE
        QC.Training_Id = @TrainingId;

END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH

GO