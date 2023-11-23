SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgDeptCreate2]
    @OrganizationId INT,
    @Dept_Name NVARCHAR(50),
    @TOwner NVARCHAR(256),
    @TStamp DATETIME2(7)
AS
BEGIN Try
    SET NOCOUNT ON;

    -- Check if the department already exists in the Departments table
    DECLARE @DepartmentId INT
    SELECT @DepartmentId = Dept_Id FROM Department WHERE Dept_Name = @Dept_Name

    -- If the department does not exist, create a new entry in the Department table
    IF @DepartmentId IS NULL
    BEGIN
        INSERT INTO Department (Dept_Name , TOwner, TStamp) VALUES (@Dept_Name, @TOwner, @TStamp)
        SET @DepartmentId = SCOPE_IDENTITY()
    END

    -- Check if the department is already associated with the organization in OrgDepts table
    IF EXISTS (
        SELECT 1
        FROM OrgDept
        WHERE Org_Id = @OrganizationId
          AND Dept_Id = @DepartmentId
    )
    BEGIN
        RAISERROR('Department already exists in the organization.', 16, 1)
        RETURN
    END

    -- Create a new OrgDept entry
    INSERT INTO OrgDept (Org_Id, Dept_Id, TStamp, TOwner)
    VALUES (@OrganizationId, @DepartmentId, @TStamp, @TOwner)

    -- Return the newly created OrgDept entry
    SELECT OD.*
    FROM OrgDept OD
    WHERE OD.Org_Id = @OrganizationId
      AND OD.Dept_Id = @DepartmentId
END Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO