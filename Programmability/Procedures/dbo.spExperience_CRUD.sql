SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spExperience_CRUD]
(
  @Exp_Id INT = NULL,
  @Company_Name NVARCHAR(50) = NULL,
  @Industry_Field_Name NVARCHAR(50) = NULL,
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
        FROM Experience
        WHERE (@Exp_Id IS NULL OR Exp_Id = @Exp_Id)
            AND (@Company_Name IS NULL OR Company_Name = @Company_Name)
            AND (@Industry_Field_Name IS NULL OR Industry_Field_Name = @Industry_Field_Name)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Experience (Company_Name, Industry_Field_Name, TStamp,TOwner,Status)
        VALUES (@Company_Name, @Industry_Field_Name, @TStamp, @TOwner, @Status)

		SELECT * FROM Experience WHERE Exp_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Experience
        SET Company_Name = ISNULL(@Company_Name,Company_Name),
            Industry_Field_Name = ISNULL(@Industry_Field_Name,Industry_Field_Name),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Status = ISNULL(@Status,Status)
        WHERE Exp_Id = @Exp_Id

		--UPDATE Experience
  --      SET Company_Name = @Company_Name,
  --          Industry_Field_Name = @Industry_Field_Name,
		--	TStamp = @TStamp,
		--	TOwner = @TOwner,
		--	Status = ISNULL(@Status,Status)
  --      WHERE Exp_Id = @Exp_Id

		SELECT * FROM Experience WHERE Exp_Id = @Exp_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Experience
        WHERE Exp_Id = @Exp_Id;

		SELECT * FROM Experience
        WHERE Exp_Id = @Exp_Id;
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO