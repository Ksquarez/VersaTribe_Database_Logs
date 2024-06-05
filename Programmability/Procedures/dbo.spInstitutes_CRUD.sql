SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spInstitutes_CRUD]
(
  @Inst_Id INT = NULL,
  @Inst_Name NVARCHAR(50) = NULL,
  @Inst_Type NVARCHAR(50) = NULL,
  @City NVARCHAR(50) = NULL,
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
        FROM Institutes
        WHERE (@Inst_Id IS NULL OR Inst_Id = @Inst_Id)
            AND (@Inst_Name IS NULL OR Inst_Name = @Inst_Name)
            AND (@Inst_Type IS NULL OR Inst_Type = @Inst_Type)
			AND (@City IS NULL OR City = @City)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Institutes (Inst_Name, Inst_Type, City, TStamp,TOwner,Status)
        VALUES (@Inst_Name, @Inst_Type, @City, @TStamp, @TOwner, @Status)

		SELECT * FROM Institutes WHERE Inst_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Institutes
        SET Inst_Name = ISNULL(@Inst_Name,Inst_Name),
            Inst_Type = ISNULL(@Inst_Type,Inst_Type),
			City = ISNULL(@City,City),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Status = ISNULL(@Status,Status)
        WHERE Inst_Id = @Inst_Id

		SELECT * FROM Institutes WHERE Inst_Id = @Inst_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Institutes
        WHERE Inst_Id = @Inst_Id

		SELECT * FROM Institutes
        WHERE Inst_Id = @Inst_Id
    END
	ELSE IF @Action = 'AUTOCOMPLETE(Inst_Name)'
    BEGIN

		SELECT * FROM Institutes
        WHERE Inst_Name LIKE @Inst_Name + '%';


    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO