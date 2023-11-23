SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spPersonExperience_CRUD]
(
  @PerExp_Id INT = NULL,
  @Person_Id INT = NULL,
  @Exp_Id INT = NULL,
  @Exp_months INT = NULL,
  @Job_Title NVARCHAR(50) = NULL,
  @Start_date DATE = NULL,
  @End_date DATE = NULL,
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
        FROM PersonExperience
        WHERE (@PerExp_Id IS NULL OR PerExp_Id = @PerExp_Id)
            AND (@Person_Id IS NULL OR Person_Id = @Person_Id)
            AND (@Exp_Id IS NULL OR Exp_Id = @Exp_Id)
			AND (@Exp_months IS NULL OR Exp_months = @Exp_months)
			AND (@Job_Title IS NULL OR Job_Title = @Job_Title)
			AND (@Start_date IS NULL OR Start_date = @Start_date)
			AND (@End_Date IS NULL OR End_Date = @End_Date)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO PersonExperience (Person_Id, Exp_Id, Exp_months, Job_Title, Start_date, End_Date, TStamp,TOwner,Status)
        VALUES (@Person_Id, @Exp_Id, @Exp_months, @Job_Title, @Start_date, @End_Date, @TStamp, @TOwner, @Status)

		SELECT * FROM PersonExperience WHERE PerExp_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE PersonExperience
        SET Person_Id = ISNULL(@Person_Id,Person_Id),
            Exp_Id = ISNULL(@Exp_Id,Exp_Id),
			Exp_months = ISNULL(@Exp_months,Exp_months),
			Job_Title = ISNULL(@Job_Title,Job_Title),
			Start_date = ISNULL(@Start_date,Start_date),
			End_Date = ISNULL(@End_Date,End_Date),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Status = ISNULL(@Status,Status)
        WHERE PerExp_Id = @PerExp_Id

		SELECT * FROM PersonExperience WHERE PerExp_Id = @PerExp_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM PersonExperience
        WHERE PerExp_Id = @PerExp_Id;

		SELECT * FROM PersonExperience
        WHERE PerExp_Id = @PerExp_Id;
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO