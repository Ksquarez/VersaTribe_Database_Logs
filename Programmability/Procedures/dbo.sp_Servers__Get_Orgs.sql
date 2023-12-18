SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_Servers__Get_Orgs]
(
  @Srv_Id INT
)

AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT
        o.Org_Name,
        o.OrgAdmin_Id,
        os.*
    FROM
        Org o
    INNER JOIN
        OrgServers os ON o.Org_Id = os.Org_Id
    WHERE
        os.Server_Id = @Srv_Id;

    
END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO