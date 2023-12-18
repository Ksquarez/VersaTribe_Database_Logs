SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_Servers__Get_ServerGroups]
(
  @Srv_Id INT
)

AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT
		sg.Srv_Group_Id,
		sg.Queue_Id,
		sg.Queue_Name,
		g.*
    FROM
        Servers s
    INNER JOIN
        ServerGroups sg ON s.Srv_Id= sg.Srv_Id
	INNER JOIN
		Groups g On sg.Group_Id = g.Group_Id
    WHERE
        s.Srv_Id= @Srv_Id;

    
END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO