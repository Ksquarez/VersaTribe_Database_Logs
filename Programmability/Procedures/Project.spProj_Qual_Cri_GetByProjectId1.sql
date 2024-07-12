SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Project].[spProj_Qual_Cri_GetByProjectId1]
    @ProjectId INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        --SELECT
        --    QC.Proj_Qual_Id,
        --    QC.Project_Id,
        --    QC.YOP,
        --    QC.Grade,
        --    QC.City,
        --    QC.Mandatory_Fields,
        --    QC.Status,
        --    QC.TStamp,
        --    QC.TOwner,
        --    Q.QI_Id,
        --    Q.Cou_Id,
        --    Q.Inst_Id,
        --    C.Cou_Name,
        --    I.Inst_Name
        --FROM
        --    dbo.Project_Qualification_Criteria QC
        --INNER JOIN
        --    dbo.Qualification Q ON QC.QI = Q.QI_Id
        --INNER JOIN
        --    dbo.Course C ON Q.Cou_Id = C.Cou_Id
        --INNER JOIN
        --    dbo.Institutes I ON Q.Inst_Id = I.Inst_Id
        --WHERE
        --    QC.Project_Id = @ProjectId;

		SELECT 1;

    END TRY
    BEGIN CATCH
        INSERT INTO dbo.DB_Errors
        VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
    END CATCH
END
GO