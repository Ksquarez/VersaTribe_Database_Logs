SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

Create Proc [Recruitment].[sp_Candidate_Qualification_CRUD]
(
  @Candidate_Qualification_Id INT = NULL,
  @Candidate_Id INT = NULL,
  @QI_Id INT = NULL,
  @YOP DATE = NULL,
  @Grade varchar(5) = NULL,
  @City nvarchar(50) = NULL,
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM [Recruitment].Candidate_Qualification
        WHERE (@Candidate_Qualification_Id IS NULL OR Candidate_Qualification_Id = @Candidate_Qualification_Id)
            AND (@Candidate_Id IS NULL OR Candidate_Id = @Candidate_Id)
			AND (@QI_Id IS NULL OR QI_Id = @QI_Id)
			AND (@YOP IS NULL OR YOP = @YOP)
			AND (@Grade IS NULL OR Grade = @Grade)
			AND (@City IS NULL OR City = @City)
			AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Candidate_Qualification (Candidate_Id, QI_Id, YOP, Grade, City, Status, TStamp, TOwner)
        VALUES (@Candidate_Id, @QI_Id, @YOP, @Grade, @City, @Status, @TStamp, @TOwner)

		SELECT * FROM Candidate_Qualification WHERE Candidate_Qualification_Id = SCOPE_IDENTITY();
    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE [Recruitment].Candidate_Qualification
        SET Candidate_Id = ISNULL(@Candidate_Id, Candidate_Id),
            QI_Id = ISNULL(@QI_Id, QI_Id),
			YOP = ISNULL(@YOP, YOP),
			Grade = ISNULL(@Grade, Grade),
			City = ISNULL(@City, City),
			Status = ISNULL(@Status, Status),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE Candidate_Qualification_Id = @Candidate_Qualification_Id

		SELECT * FROM [Recruitment].Candidate_Qualification WHERE Candidate_Qualification_Id = @Candidate_Qualification_Id
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM [Recruitment].Candidate_Qualification
        WHERE Candidate_Qualification_Id = @Candidate_Qualification_Id

		SELECT * FROM Candidate_Qualification WHERE Candidate_Qualification_Id = @Candidate_Qualification_Id
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO