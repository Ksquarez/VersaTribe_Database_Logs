SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [Project].[spProjectQualificationCriteria_CRUD1]
(
   @Proj_Qual_Id INT = NULL,
    @Project_Id INT,
    @QI INT,
    @YOP DATE,
    @Grade VARCHAR(5),
    @City NVARCHAR(50),
    @TStamp DATETIME2,
    @TOwner NVARCHAR(256),
    @Status INT = 0,
    @Mandatory_Fields NVARCHAR(MAX) = NULL,
    @Action NVARCHAR(10)
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    --IF @Action = 'SELECT'
    --    BEGIN
    --        SELECT *
    --        FROM Project_Qualification_Criteria
    --        WHERE (@Proj_Qual_Id IS NULL OR Proj_Qual_Id = @Proj_Qual_Id)
    --            AND (@Project_Id IS NULL OR Project_Id = @Project_Id)
    --            AND (@QI IS NULL OR QI = @QI)
    --            AND (@YOP IS NULL OR YOP = @YOP)
    --            AND (@Grade IS NULL OR Grade = @Grade)
    --            AND (@City IS NULL OR City = @City)
    --            AND (@Mandatory_Fields IS NULL OR Mandatory_Fields = @Mandatory_Fields)
    --            AND (@Status IS NULL OR Status = @Status)
    --            AND (@TStamp IS NULL OR TStamp = @TStamp)
    --            AND (@TOwner IS NULL OR TOwner = @TOwner);
    --END
    --ELSE IF @Action = 'INSERT'
    --    BEGIN
    --        INSERT INTO Project_Qualification_Criteria (Project_Id, QI, YOP, Grade, City, Status, TStamp, TOwner, Mandatory_Fields)
    --        VALUES (@Project_Id, @QI, @YOP, @Grade, @City, @Status, @TStamp, @TOwner, @Mandatory_Fields);

    --        SELECT * FROM Project_Qualification_Criteria WHERE Proj_Qual_Id = SCOPE_IDENTITY();
    --END
    --ELSE IF @Action = 'UPDATE'
    --    BEGIN
    --        UPDATE Project_Qualification_Criteria
    --        SET Project_Id = ISNULL(@Project_Id, Project_Id),
    --            QI = ISNULL(@QI, QI),
    --            YOP = ISNULL(@YOP, YOP),
    --            Grade = ISNULL(@Grade, Grade),
    --            City = ISNULL(@City, City),
    --            Status = ISNULL(@Status, Status),
    --            TStamp = ISNULL(@TStamp, TStamp),
    --            TOwner = ISNULL(@TOwner, TOwner),
    --            Mandatory_Fields = ISNULL(@Mandatory_Fields, Mandatory_Fields)
    --        WHERE Proj_Qual_Id = @Proj_Qual_Id;

    --        SELECT * FROM Project_Qualification_Criteria WHERE Proj_Qual_Id = @Proj_Qual_Id;
    --    END
    --ELSE IF @Action = 'DELETE'
    --    BEGIN
    --        DELETE FROM Project_Qualification_Criteria
    --        WHERE Proj_Qual_Id = @Proj_Qual_Id;

    --        SELECT * FROM Project_Qualification_Criteria WHERE Proj_Qual_Id = @Proj_Qual_Id;
    --END

	SELECT 1;

END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH

GO