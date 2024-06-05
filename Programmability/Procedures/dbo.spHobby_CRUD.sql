SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spHobby_CRUD]
(
  @Hobby_Id INT = NULL,
  @Name NVARCHAR(50) = NULL,
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
        FROM Hobby
        WHERE   (@Hobby_Id IS NULL OR Hobby_Id = @Hobby_Id)
            AND (@Name IS NULL OR Name = @Name)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
			
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Hobby (Name, Status,TStamp,TOwner)
        VALUES (@Name, @Status, @TStamp, @TOwner)

		SELECT * FROM Hobby WHERE Hobby_Id = SCOPE_IDENTITY();
    END

	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Hobby
        SET Name = ISNULL(@Name,Name),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE Hobby_Id = @Hobby_Id

		SELECT * FROM Hobby WHERE Hobby_Id = @Hobby_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Hobby
        WHERE Hobby_Id = @Hobby_Id
		SELECT * FROM Hobby
        WHERE Hobby_Id = @Hobby_Id
    END
	ELSE IF @Action = 'AUTOCOMPLETE(NAME)'
    BEGIN
        
		SELECT * FROM Hobby
        WHERE Name LIKE @Name + '%';

    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO