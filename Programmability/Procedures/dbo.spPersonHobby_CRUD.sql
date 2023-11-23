SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spPersonHobby_CRUD]
(
  @Person_Id INT = NULL,
  @Hobby_Id INT = NULL,
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
        FROM PersonHobby
        WHERE (@Person_Id IS NULL OR Person_Id = @Person_Id)
            AND (@Hobby_Id IS NULL OR Hobby_Id = @Hobby_Id)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO PersonHobby (Person_Id, Hobby_Id, TStamp,TOwner,Status)
        VALUES (@Person_Id, @Hobby_Id, @TStamp, @TOwner, @Status)

		SELECT * FROM PersonHobby WHERE Person_Id = @Person_Id AND Hobby_Id = @Hobby_Id

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE PersonHobby
        SET Person_Id = ISNULL(@Person_Id,Person_Id),
            Hobby_Id = ISNULL(@Hobby_Id,Hobby_Id),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Status = ISNULL(@Status,Status)
        WHERE Person_Id = @Person_Id AND Hobby_Id = @Hobby_Id

		SELECT * FROM PersonHobby WHERE Person_Id = @Person_Id AND Hobby_Id = @Hobby_Id

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM PersonHobby
        WHERE Person_Id = @Person_Id AND Hobby_Id = @Hobby_Id

		SELECT * FROM PersonHobby
        WHERE Person_Id = @Person_Id AND Hobby_Id = @Hobby_Id
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO