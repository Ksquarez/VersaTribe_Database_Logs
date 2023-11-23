SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgInfoByOrgAdmin]
(
  @OrgAdmin_Id nvarchar(256)
)
AS
BEGIN TRY

	SET NOCOUNT ON;
SELECT       Org.Org_Name,Org.OrgAdmin_Id,OrgInfo.*
FROM            Org INNER JOIN
                         OrgInfo ON Org.Org_Id = OrgInfo.Org_Id
						 WHERE Org.OrgAdmin_Id = @OrgAdmin_Id

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO