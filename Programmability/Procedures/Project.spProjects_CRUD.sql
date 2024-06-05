SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Project].[spProjects_CRUD]
(
	@Project_Id INT = NULL,
	@Project_Name nvarchar(50)= NULL,
	@Person_Id int= NULL,
	@Status int= NULL,
	@Start_Date date= NULL,
	@End_Date date= NULL,
	@TStamp datetime2= NULL,
	@TOwner nvarchar(256)= NULL,
	@Org_Id int= NULL,
	@Progress int= NULL,
    @Action NVARCHAR(100)
)
AS
Begin Try
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Projects
        WHERE (@Project_Id IS NULL OR Project_Id = @Project_Id)
			AND (@Project_Name IS NULL OR Project_Name = @Project_Name)
            AND (@Person_Id IS NULL OR Person_Id = @Person_Id)
			AND (@Status IS NULL OR Status = @Status)
			AND (@Start_Date IS NULL OR Start_Date = @Start_Date)
			AND (@End_Date IS NULL OR End_Date = @End_Date)            
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Org_Id IS NULL OR Org_Id = @Org_Id)
			AND (@Progress IS NULL OR Progress = @Progress)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Projects(Project_Name, Person_Id, Status, Start_Date,End_Date, TStamp, TOwner,Org_Id,Progress)
        VALUES (@Project_Name , @Person_Id,@Status,@Start_Date,@End_Date, @TStamp, @TOwner,@Org_Id,@Progress)

		SELECT * FROM Projects WHERE Project_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Projects
        SET 
		    Project_Name = ISNULL(@Project_Name,Project_Name),
			Person_Id = ISNULL(@Person_Id,Person_Id),
		    Status = ISNULL(@Status,Status),
			Start_Date = ISNULL(@Start_Date,Start_Date),
			End_Date = ISNULL(@End_Date,End_Date),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Org_Id = ISNULL(@Org_Id,Org_Id),
			Progress = ISNULL(@Progress,Progress)
        WHERE Project_Id = @Project_Id;

		SELECT * FROM Projects  WHERE Project_Id = @Project_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Projects
        WHERE Project_Id = @Project_Id;

		Select * FROM Projects Where Project_Id = @Project_Id;

    END
END TRY	

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO