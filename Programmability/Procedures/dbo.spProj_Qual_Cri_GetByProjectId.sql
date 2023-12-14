SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create PROCEDURE [dbo].[spProj_Qual_Cri_GetByProjectId]
    @ProjectId INT
AS
BEGIN TRY
    SELECT
        QC.Proj_Qual_Id AS Proj_Qual_Id,
        QC.Project_Id,
        QC.Cou_Id,
        C.Cou_Name,
        QC.Status,
        QC.TStamp,
        QC.TOwner,
        QC.Mandatory
    FROM
        Project_Qualification_Criteria QC
    INNER JOIN
        Course C ON QC.Cou_Id = C.Cou_Id
    WHERE
        QC.Project_Id = @ProjectId;

END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH

GO