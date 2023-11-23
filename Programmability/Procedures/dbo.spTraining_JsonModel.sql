SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spTraining_JsonModel]
(
  @Training_Id INT = NULL,
  @Org_Id INT = NULL,
  @Trainer_Id NVARCHAR(256) = NULL,
  @Training_Name NVARCHAR(50) = NULL,
  @Description NVARCHAR(MAX) = NULL,
  @Status INT = NULL,
  @Start_Date DATE = NULL,
  @End_Date DATE = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @PageSize INT = NULL,
  @PageNumber INT = NULL,
  @PersonLimit INT = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Training
        WHERE (@Training_Id IS NULL OR Training_Id = @Training_Id)
			AND (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@Trainer_Id IS NULL OR Trainer_Id = @Trainer_Id)
            AND (@Training_Name IS NULL OR Training_Name = @Training_Name)
            AND (@Description IS NULL OR Description = @Description)
			AND (@Status IS NULL OR Status = @Status)
			AND (@Start_Date IS NULL OR Start_Date = @Start_Date)
			AND (@End_Date IS NULL OR End_Date = @End_Date)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			FOR JSON  PATH, INCLUDE_NULL_VALUES
    END
	ELSE IF @Action = 'api/Trainings/{Training_Id}/Org'
    BEGIN
        SELECT Org.Org_Name,Org.Org_Id , Training.Training_Id
		FROM Org
		INNER JOIN Training ON Org.Org_Id = Training.Org_Id
        WHERE (Training.Training_Id = @Training_Id)
			FOR JSON  PATH, INCLUDE_NULL_VALUES, WITHOUT_ARRAY_WRAPPER
    END
	ELSE IF @Action = 'api/Trainings/Org/{Org_Id}/Trainings'
    BEGIN
        SELECT Training.* 
		FROM Training
		INNER JOIN Org ON Org.Org_Id = Training.Org_Id
        WHERE (Training.Org_Id = @Org_Id)
            FOR JSON  PATH, INCLUDE_NULL_VALUES
	END
	ELSE IF @Action = 'api/Trainings/Trainer/{Trainer_Id}/Trainings'
    BEGIN
        SELECT Training.* 
		FROM Training		
        WHERE (Training.Trainer_Id = @Trainer_Id)
            FOR JSON  PATH, INCLUDE_NULL_VALUES
	END
	ELSE IF @Action = 'api/Trainings/Org/{Org_Id}/Trainer/{Trainer_Id}/Trainings'
    BEGIN
        SELECT Training.* 
		FROM Training		
        WHERE (Training.Trainer_Id = @Trainer_Id AND Training.Org_Id = @Org_Id)
            FOR JSON  PATH, INCLUDE_NULL_VALUES
	END
	ELSE IF @Action = 'api/Trainings/Org/{Org_Id}/Trainings/{Training_Id}'
    BEGIN
        SELECT Training.* 
		FROM Training
		INNER JOIN Org ON Org.Org_Id = Training.Org_Id
        WHERE (Training.Org_Id = @Org_Id AND Training.Training_Id = @Training_Id)
            FOR JSON  PATH, INCLUDE_NULL_VALUES, WITHOUT_ARRAY_WRAPPER
	END
	ELSE IF @Action = 'api/Training/User/GetListPaging'
	BEGIN		
		DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
		SELECT 
		Training.*
		FROM
		Training
		ORDER BY Training.Start_Date
		OFFSET @Offset ROWS
		FETCH NEXT @PageSize ROWS ONLY
		FOR JSON Auto, INCLUDE_NULL_VALUES

	END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO