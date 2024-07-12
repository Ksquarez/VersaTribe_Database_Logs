SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Recruitment].[sp_Job_Request_Qualification_CRUD]
(
  @Job_Request_Qual_Id INT = NULL,
  @Job_Request_Id INT = NULL,
  @QI INT = NULL,
  @YOP DATE,
  @Grade VARCHAR(5),
  @City NVARCHAR(50),
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,  
  @Mandatory BIT = NULL,
  @Status INT = 0,  
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Recruitment.Job_Request_Qualification
        WHERE (@Job_Request_Qual_Id IS NULL OR Job_Request_Qual_Id = @Job_Request_Qual_Id)
            AND (@Job_Request_Id IS NULL OR Job_Request_Id = @Job_Request_Id)
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
        INSERT INTO Recruitment.Job_Request_Qualification (Job_Request_Id, QI, YOP, Grade, City, Status, TStamp, TOwner, Mandatory)
        VALUES (@Job_Request_Id, @QI, @YOP, @Grade, @City, @Status, @TStamp, @TOwner, @Mandatory)

        SELECT * FROM Recruitment.Job_Request_Qualification WHERE Job_Request_Qual_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Recruitment.Job_Request_Qualification
        SET Job_Request_Id = ISNULL(@Job_Request_Id, Job_Request_Id),
            QI = ISNULL(@QI, QI),
            YOP = ISNULL(@YOP, YOP),
            Grade = ISNULL(@Grade, Grade),
            City = ISNULL(@City, City),
            Status = ISNULL(@Status, Status),
            TStamp = ISNULL(@TStamp, TStamp),
            TOwner = ISNULL(@TOwner, TOwner),
            Mandatory = ISNULL(@Mandatory, Mandatory)
        WHERE Job_Request_Qual_Id = @Job_Request_Qual_Id;

        SELECT * FROM Recruitment.Job_Request_Qualification WHERE Job_Request_Qual_Id = @Job_Request_Qual_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Recruitment.Job_Request_Qualification
        WHERE Job_Request_Qual_Id = @Job_Request_Qual_Id;

        SELECT * FROM Recruitment.Job_Request_Qualification WHERE Job_Request_Qual_Id = @Job_Request_Qual_Id;
    END
END TRY
BEGIN CATCH
   INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO