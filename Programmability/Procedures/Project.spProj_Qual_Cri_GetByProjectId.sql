SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Project].[spProj_Qual_Cri_GetByProjectId]
    @ProjectId INT
AS
BEGIN TRY
    SELECT
        QC.Proj_Qual_Id AS Proj_Qual_Id,
        QC.Project_Id,
        QC.QI,
        C.Cou_Name,
		I.Inst_Name,
		QC.YOP,
		QC.Grade,
		QC.City,
        QC.Mandatory,
        QC.Status,
        QC.TStamp,
        QC.TOwner
    FROM
        Project_Qualification_Criteria QC
		LEFT JOIN 
		Qualification Q ON QC.QI = Q.QI_Id
		LEFT JOIN
        Course C ON Q.Cou_Id = C.Cou_Id
		LEFT JOIN
		Institutes I ON Q.Inst_Id = I.Inst_Id
    WHERE
        QC.Project_Id = @ProjectId;

END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH

GO