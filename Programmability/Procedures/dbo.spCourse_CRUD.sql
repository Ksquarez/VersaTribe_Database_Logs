SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spCourse_CRUD]
(
  @Cou_Id INT = NULL,
  @Cou_Name NVARCHAR(256) = NULL,
  @CTyp_Id INT = NULL,
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
        FROM Course
        WHERE (@Cou_Id IS NULL OR Cou_Id = @Cou_Id)
            AND (@Cou_Name IS NULL OR Cou_Name = @Cou_Name)
            AND (@CTyp_Id IS NULL OR CTyp_Id = @CTyp_Id)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Course (Cou_Name, CTyp_Id, TStamp,TOwner,Status)
        VALUES (@Cou_Name, @CTyp_Id, @TStamp, @TOwner, @Status)

		SELECT * FROM Course WHERE Cou_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Course
        SET Cou_Name = ISNULL(@Cou_Name,Cou_Name),
            CTyp_Id = ISNULL(@CTyp_Id,CTyp_Id),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Status = ISNULL(@Status,Status)
        WHERE Cou_Id = @Cou_Id

		SELECT * FROM Course WHERE Cou_Id = @Cou_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Course
        WHERE Cou_Id = @Cou_Id

		SELECT * FROM Course
        WHERE Cou_Id = @Cou_Id
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO