SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spExperienceCri_CRUD]
(
  @Id INT = NULL,
  @Training_Id INT = NULL,
  @Exp_Id INT = NULL,
  @Exp_months INT = NULL,
  @Job_Title nvarchar(50),
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
        FROM Experience_Criteria
        WHERE (@Training_Id IS NULL OR Training_Id = @Training_Id)
            AND (@Exp_Id IS NULL OR Exp_Id = @Exp_Id)
            AND (@Exp_months IS NULL OR Exp_months = @Exp_months)
			AND (@Job_Title IS NULL OR Job_Title = @Job_Title)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
			AND (@Id IS NULL OR Id = @Id)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Experience_Criteria(Training_Id, Exp_Id,Exp_months,Job_Title , Status,TStamp, TOwner, Mandatory)
        VALUES (@Training_Id, @Exp_Id, @Exp_months,@Job_Title , @Status,@TStamp, @TOwner, @Mandatory)

		SELECT * FROM Experience_Criteria WHERE Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Experience_Criteria
        SET Training_Id = ISNULL(@Training_Id, Training_Id),
            Exp_Id = ISNULL(@Exp_Id,Exp_Id),
			Exp_months = ISNULL(@Exp_months,Exp_months),
			Job_Title = ISNULL(@Job_Title,Job_Title),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Mandatory = ISNULL(@Mandatory,Mandatory)
        WHERE Id = @Id;

		SELECT * FROM Experience_Criteria  WHERE Id = @Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN

        DELETE FROM Experience_Criteria
         WHERE Id = @Id;

		Select * FROM Experience_Criteria Where Id = @Id;

    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH

GO