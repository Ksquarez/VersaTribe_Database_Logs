SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GroupExtension_Delete]
    @Grp_Ext_Id INT
AS
BEGIN TRY
	SET NOCOUNT ON;

    DELETE FROM [dbo].[GroupExtensions]
    WHERE [Grp_Ext_Id] = @Grp_Ext_Id;
END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO