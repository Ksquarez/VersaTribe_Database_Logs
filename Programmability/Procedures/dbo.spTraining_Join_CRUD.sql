SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spTraining_Join_CRUD]
(
  @Training_Id INT = NULL,
  @Person_Id INT = NULL,
  @Is_Join bit = NULL, 
  @Joined_At DATETIME = NULL,
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
        FROM Training_Join
        WHERE (@Training_Id IS NULL OR Training_Id = @Training_Id)
            AND (@Person_Id IS NULL OR Person_Id = @Person_Id)
            AND (@Is_Join IS NULL OR Is_Join = @Is_Join)
			AND (@Joined_At IS NULL OR Joined_At = @Joined_At)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			
		
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN


        INSERT INTO Training_Join (Training_Id, Person_Id, Is_Join, Joined_At, Status,TStamp,TOwner)
        VALUES (@Training_Id, @Person_Id, @Is_Join, @Joined_At, @Status, @TStamp, @TOwner)

		SELECT * FROM Training_Join WHERE Training_Id =  @Training_Id AND Person_Id = @Person_Id

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Training_Join
        SET Training_Id = ISNULL(@Training_Id,Training_Id),
		    Person_Id = ISNULL(@Person_Id,Person_Id),
			Is_Join = ISNULL(@Is_Join,Is_Join),
			Joined_At = ISNULL(@Joined_At,Joined_At),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE Training_Id =  @Training_Id AND Person_Id = @Person_Id

		SELECT * FROM Training_Join WHERE Training_Id =  @Training_Id AND Person_Id = @Person_Id

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Training_Join
        WHERE Training_Id =  @Training_Id AND Person_Id = @Person_Id

		SELECT * FROM Training_Join
        WHERE Training_Id =  @Training_Id AND Person_Id = @Person_Id
    END
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

  THROW;

END CATCH
GO