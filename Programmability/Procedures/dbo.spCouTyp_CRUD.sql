SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spCouTyp_CRUD]
(
  @CTyp_Id INT = NULL,
  @Ctyp_Name NVARCHAR(50) = NULL,
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
        FROM CourseType
        WHERE   (@CTyp_Id IS NULL OR CTyp_Id = @CTyp_Id)
            AND (@Ctyp_Name IS NULL OR Ctyp_Name = @Ctyp_Name)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO CourseType (Ctyp_Name, Status,TStamp,TOwner)
        VALUES (@Ctyp_Name, @Status, @TStamp, @TOwner)

		SELECT * FROM CourseType WHERE CTyp_Id = SCOPE_IDENTITY();
    END

	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE CourseType
        SET Ctyp_Name = ISNULL(@Ctyp_Name,Ctyp_Name),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE CTyp_Id = @CTyp_Id

		SELECT * FROM CourseType WHERE CTyp_Id = @CTyp_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM CourseType
        WHERE CTyp_Id = @CTyp_Id
		SELECT * FROM CourseType
        WHERE CTyp_Id = @CTyp_Id
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO