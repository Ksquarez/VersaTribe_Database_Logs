SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE Proc [Project].[spProject_User_CRUD]
(
  @Id INT = NULL,
  @Person_Id INT = NULL,
  @Project_Id INT = NULL,
  @Status INT = NULL,
  @Role NVARCHAR(50) = NULL,
  @IsApproved BIT = NULL,
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
        FROM Project_User
        WHERE (@Id IS NULL OR Id = @Id)
            AND (@Person_Id IS NULL OR Person_Id = @Person_Id)
			AND (@Project_Id IS NULL OR Project_Id = @Project_Id)
			AND (@Role IS NULL OR Role = @Role)
			AND (@IsApproved IS NULL OR IsApproved = @IsApproved) 
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Project_User(Person_Id , Project_Id, Role, Status,IsApproved, TStamp, TOwner)
        VALUES (@Person_Id , @Project_Id, @Role, @Status,@IsApproved, @TStamp, @TOwner)

		SELECT * FROM Project_User WHERE Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
   --     UPDATE Project_User
   --     SET 
		 --   Person_Id = ISNULL(@Person_Id,Person_Id),
		 --   Project_Id = ISNULL(@Project_Id,Project_Id),
		 --   Role = ISNULL(@Role,Role),
			--IsApproved = ISNULL(@IsApproved, IsApproved),
   --         Status = ISNULL(@Status,Status),
			--TStamp = @TStamp,
			--TOwner = @TOwner
   --     WHERE Id = @Id;
    UPDATE Project_User
        SET 
            Person_Id = ISNULL(@Person_Id, Person_Id),
            Project_Id = ISNULL(@Project_Id, Project_Id),
            Role = ISNULL(@Role, Role),
            IsApproved = 
                CASE 
                    WHEN @IsApproved = 1 THEN 1        -- Accepted
                    WHEN @IsApproved = -1 THEN -1      -- Rejected
                    ELSE ISNULL(@IsApproved, IsApproved) -- Requested 
                END,
            Status = ISNULL(@Status, Status),
            TStamp = @TStamp,
            TOwner = @TOwner
        WHERE Id = @Id;

		SELECT * FROM Project_User  WHERE Id = @Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Project_User
        WHERE Id = @Id;

		Select * FROM Project_User Where Id = @Id;

    END
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH

GO