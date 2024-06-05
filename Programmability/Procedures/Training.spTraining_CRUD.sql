SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE Proc [Training].[spTraining_CRUD]
(
  @Training_Id INT = NULL,
  @Org_Id INT = NULL,
  @Trainer_Id INT = NULL,
  @Training_Name NVARCHAR(50) = NULL,
  @Description NVARCHAR(MAX) = NULL,
  @Status INT = NULL,
  @Start_Date DATE = NULL,
  @End_Date DATE = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
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
			AND (@PersonLimit IS NULL OR TOwner = @PersonLimit)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Training (Trainer_Id, Org_Id, Training_Name, Description,Status,Start_Date,End_Date,TStamp,TOwner,PersonLimit)
        VALUES (@Trainer_Id, @Org_Id, @Training_Name, @Description, @Status, @Start_Date, @End_Date, @TStamp, @TOwner,@PersonLimit)

		SELECT * FROM Training WHERE Training_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Training
        SET Training_Name = ISNULL(@Training_Name,Training_Name),
		    Org_Id = ISNULL(@Org_Id,Org_Id),
            Description = ISNULL(@Description,Description),
            Status = ISNULL(@Status,Status),
			Start_Date = ISNULL(@Start_Date,Start_Date),
			End_Date = ISNULL(@End_Date,End_Date),
			TStamp = @TStamp,
			TOwner = @TOwner,
			PersonLimit = ISNULL(@PersonLimit,PersonLimit)
        WHERE Training_Id = @Training_Id

		SELECT * FROM Training WHERE Training_Id = @Training_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Training
        WHERE Training_Id = @Training_Id

		SELECT * FROM Training
        WHERE Training_Id = @Training_Id
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO