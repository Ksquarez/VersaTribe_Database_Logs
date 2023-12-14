SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GroupExtension_Update]
    @Grp_Ext_Id INT,
    @Extension_Id INT,
    @Srv_Group_Id INT,
    @Group_Id INT
AS
BEGIN TRY
	SET NOCOUNT ON;
    UPDATE [dbo].[GroupExtensions]
    SET [Extension_Id] = @Extension_Id,
        [Srv_Group_Id] = @Srv_Group_Id,
        [Group_Id] = @Group_Id
    WHERE [Grp_Ext_Id] = @Grp_Ext_Id;
END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO