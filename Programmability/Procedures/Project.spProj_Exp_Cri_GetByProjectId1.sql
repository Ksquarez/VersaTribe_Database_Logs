﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Project].[spProj_Exp_Cri_GetByProjectId1]
    @ProjectId INT
AS
BEGIN TRY
  --  SELECT
  --      EC.Proj_Exp_Id,
  --      --EC.Project_Id,
  --      EC.Exp_Id,
		--E.Company_Name,
		--E.Industry_Field_Name,
  --      EC.Exp_months,
  --      EC.Job_Title,
  --      EC.Status,
  --      EC.TStamp,
  --      EC.TOwner,
  --      EC.Mandatory_Fields
  --  FROM
  --      Project_Experience_Criteria EC
  --  INNER JOIN
  --      Experience E ON EC.Exp_Id = E.Exp_Id
  --  WHERE
  --      EC.Project_Id = @ProjectId;

  SELECT 1;

END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH

GO