SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spPersonQualification_CRUD]
(
  @PQ_Id INT = NULL,
  @QI_Id INT = NULL,
  @Person_Id INT = NULL,
  @YOP DATE = NULL,
  @Grade varchar(5) = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Status INT = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM PersonQualification
        WHERE (@PQ_Id IS NULL OR PQ_Id = @PQ_Id)
            AND (@QI_Id IS NULL OR QI_Id = @QI_Id)
			AND (@Person_Id IS NULL OR Person_Id = @Person_Id)
			AND (@YOP IS NULL OR YOP = @YOP)
			AND (@Grade IS NULL OR Grade = @Grade)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO PersonQualification (QI_Id, Person_Id, YOP, Grade, TStamp, TOwner, Status)
        VALUES (@QI_Id, @Person_Id, @YOP, @Grade, @TStamp, @TOwner, @Status)

		SELECT * FROM PersonQualification WHERE PQ_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE PersonQualification
        SET QI_Id = ISNULL(@QI_Id,QI_Id),
            Person_Id = ISNULL(@Person_Id,Person_Id),
			YOP = ISNULL(@YOP,YOP),
			Grade = ISNULL(@Grade,Grade),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Status = ISNULL(@Status,Status)
        WHERE PQ_Id = @PQ_Id

		SELECT * FROM PersonQualification WHERE PQ_Id = @PQ_Id

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM PersonQualification
        WHERE PQ_Id = @PQ_Id

		SELECT * FROM PersonQualification
        WHERE PQ_Id = @PQ_Id
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO