SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spTraining_Join_JsonModel]
(
  @Training_Id INT = NULL,
  @Person_Id INT = NULL,
  @Is_Join INT = NULL, -- NULLABLE
  @Joined_At DATETIME = NULL, -- NULLABLE
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
			FOR JSON  PATH, INCLUDE_NULL_VALUES		
    END
	 ELSE IF @Action = 'Join_Person'
    BEGIN
	SELECT Training_Join.*,
	       Person.TOwner AS 'Person.TOwner',
		   Person.FirstName As 'Person.FirstName'
        FROM Training_Join
		INNER JOIN Person ON Person.Person_Id = Training_Join.Person_Id
        WHERE (@Training_Id IS NULL OR Training_Join.Training_Id = @Training_Id)
            AND (@Person_Id IS NULL OR Training_Join.Person_Id = @Person_Id)
            AND (@Is_Join IS NULL OR Training_Join.Is_Join = @Is_Join)
			AND (@Joined_At IS NULL OR Training_Join.Joined_At = @Joined_At)
            AND (@Status IS NULL OR Training_Join.Status = @Status)
			AND (@TStamp IS NULL OR Training_Join.TStamp = @TStamp)
			AND (@TOwner IS NULL OR Training_Join.TOwner = @TOwner)
			FOR JSON  PATH, INCLUDE_NULL_VALUES
    END
	ELSE IF @Action = 'Join_Training'
    BEGIN

	SELECT Training_Join.*,
	       Training.Training_Name As 'Training.Training_Name'
        FROM Training_Join
		INNER JOIN Training ON Training.Training_Id = Training_Join.Training_Id
        WHERE (@Training_Id IS NULL OR Training_Join.Training_Id = @Training_Id)
            AND (@Person_Id IS NULL OR Training_Join.Person_Id = @Person_Id)
            AND (@Is_Join IS NULL OR Training_Join.Is_Join = @Is_Join)
			AND (@Joined_At IS NULL OR Training_Join.Joined_At = @Joined_At)
            AND (@Status IS NULL OR Training_Join.Status = @Status)
			AND (@TStamp IS NULL OR Training_Join.TStamp = @TStamp)
			AND (@TOwner IS NULL OR Training_Join.TOwner = @TOwner)
			FOR JSON  PATH, INCLUDE_NULL_VALUES

    END
	ELSE IF @Action = 'Join_All'
    BEGIN

	SELECT Training_Join.*,
	       Training.Training_Name As 'Training.Training_Name',
		   Person.TOwner AS 'Person.TOwner',
		   Person.FirstName As 'Person.FirstName'
        FROM Training_Join
		INNER JOIN Training ON Training.Trainer_Id = Training_Join.Training_Id
		INNER JOIN Person ON Person.Person_Id = Training_Join.Person_Id
        WHERE (@Training_Id IS NULL OR Training_Join.Training_Id = @Training_Id)
            AND (@Person_Id IS NULL OR Training_Join.Person_Id = @Person_Id)
            AND (@Is_Join IS NULL OR Training_Join.Is_Join = @Is_Join)
			AND (@Joined_At IS NULL OR Training_Join.Joined_At = @Joined_At)
            AND (@Status IS NULL OR Training_Join.Status = @Status)
			AND (@TStamp IS NULL OR Training_Join.TStamp = @TStamp)
			AND (@TOwner IS NULL OR Training_Join.TOwner = @TOwner)
			FOR JSON  PATH, INCLUDE_NULL_VALUES

    END

	ELSE IF @Action = 'api/Training_Join/Training/{Training_Id}/Persons/Join_Requests'
    BEGIN

	SELECT Training.Training_Name,
	       Person.Person_Id,
		   Person.FirstName,
		   Person.TOwner,
		   Training_Join.Is_Join,
		   (CASE WHEN Training_Join.Is_Join= 1 THEN 'APPROVED'
		         WHEN Training_Join.Is_Join= 0 THEN 'REQUESTED'
		         WHEN Training_Join.Is_Join= -1 THEN 'REJECTED'
		         WHEN Training_Join.Is_Join= -2 THEN 'REMOVED'
		 ELSE NULL
		END) AS Is_Join_Str  ,
		   Training_Join.Joined_At
	FROM Training_Join
	INNER JOIN Person ON Person.Person_Id = Training_Join.Person_Id
	INNER JOIN Training ON Training.Training_Id = Training_Join.Training_Id
	    WHERE Training_Join.Training_Id = @Training_Id
            FOR JSON  PATH, INCLUDE_NULL_VALUES
    END
	ELSE IF @Action = 'api/Training_Join/Person/{Person_Id}/Trainings/Join_Requests'
    BEGIN

	SELECT Training.Training_Name,
	       Training.Training_Id,
		   Training_Join.Is_Join,
		   (CASE WHEN Training_Join.Is_Join= 1 THEN 'APPROVED'
		         WHEN Training_Join.Is_Join= 0 THEN 'REQUESTED'
		         WHEN Training_Join.Is_Join= -1 THEN 'REJECTED'
		         WHEN Training_Join.Is_Join= -2 THEN 'REMOVED'
		 ELSE NULL
		END) AS Is_Join_Str  ,
		   Training_Join.Joined_At
	FROM Training_Join
	INNER JOIN Person ON Person.Person_Id = Training_Join.Person_Id
	INNER JOIN Training ON Training.Training_Id = Training_Join.Training_Id
	    WHERE Person.Person_Id = @Person_Id
            FOR JSON  PATH, INCLUDE_NULL_VALUES
    END



	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

  THROW;

END CATCH
GO