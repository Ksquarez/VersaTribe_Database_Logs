SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


Create PROC [Project].[spProjectQualificationCriteria_CRUD]
(
  @Proj_Qual_Id INT = NULL,
  @Project_Id INT = NULL,
  @QI INT= NULL,
  @YOP DATE= NULL,
  @Grade VARCHAR(5)= NULL,
  @City NVARCHAR(50)= NULL,
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Mandatory BIT = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Project_Qualification_Criteria
         WHERE (@Proj_Qual_Id IS NULL OR Proj_Qual_Id = @Proj_Qual_Id)
            AND (@Project_Id IS NULL OR Project_Id = @Project_Id)
            AND (@QI IS NULL OR QI = @QI)
            AND (@YOP IS NULL OR YOP = @YOP)
            AND (@Grade IS NULL OR Grade = @Grade)
            AND (@City IS NULL OR City = @City)
            AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner);
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
         INSERT INTO [dbo].[Project_Qualification_Criteria] (Project_Id, QI, YOP, Grade, City, Mandatory, Status, TStamp, TOwner)
        VALUES (@Project_Id, @QI, @YOP, @Grade, @City, @Mandatory, @Status, @TStamp, @TOwner);

        SELECT * FROM [dbo].[Project_Qualification_Criteria] WHERE Proj_Qual_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE [dbo].[Project_Qualification_Criteria]
        SET Project_Id = ISNULL(@Project_Id, Project_Id),
            QI = ISNULL(@QI, QI),
            YOP = ISNULL(@YOP, YOP),
            Grade = ISNULL(@Grade, Grade),
            City = ISNULL(@City, City),
            Mandatory = ISNULL(@Mandatory, Mandatory),
            Status = ISNULL(@Status, Status),
            TStamp = ISNULL(@TStamp, TStamp),
            TOwner = ISNULL(@TOwner, TOwner)
        WHERE Proj_Qual_Id = @Proj_Qual_Id;

        SELECT * FROM [dbo].[Project_Qualification_Criteria] WHERE Proj_Qual_Id = @Proj_Qual_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Project_Qualification_Criteria
        WHERE Proj_Qual_Id = @Proj_Qual_Id;

        SELECT * FROM Project_Qualification_Criteria WHERE Proj_Qual_Id = @Proj_Qual_Id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH

GO