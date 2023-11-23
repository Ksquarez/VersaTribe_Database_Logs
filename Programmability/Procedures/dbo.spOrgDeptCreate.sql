SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgDeptCreate]
(
    @Org_Id INT,
    @Dept_Id INT,
    @TOwner NVARCHAR(256),
    @TStamp DATETIME2(7)
)
AS
BEGIN TRY
    SET NOCOUNT ON;
    
    -- Create a new OrgDept entry
    INSERT INTO OrgDept (Org_Id, Dept_Id, TStamp, TOwner)
    VALUES (@Org_Id, @Dept_Id, @TStamp, @TOwner)

    -- Return the newly created OrgDept entry
    SELECT OD.*
    FROM OrgDept OD
    WHERE OD.Org_Id = @Org_Id AND OD.Dept_Id = @Dept_Id

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO