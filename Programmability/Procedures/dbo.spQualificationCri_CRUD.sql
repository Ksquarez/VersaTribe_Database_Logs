SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spQualificationCri_CRUD]
(
  @Id INT = NULL,
  @Training_Id INT = NULL,
  @Cou_Id INT = NULL,
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Mandatory BIT = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Qualification_Criteria
        WHERE (@Training_Id IS NULL OR Training_Id = @Training_Id)
            AND (@Cou_Id IS NULL OR Cou_Id = @Cou_Id)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
            AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
			AND (@Id IS NULL OR Id = @Id)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Qualification_Criteria (Training_Id, Cou_Id, Status, TStamp, TOwner, Mandatory)
        VALUES (@Training_Id, @Cou_Id, @Status, @TStamp, @TOwner, @Mandatory)

        SELECT * FROM Qualification_Criteria WHERE Id = SCOPE_IDENTITY();

    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Qualification_Criteria
        SET Training_Id = ISNULL(@Training_Id, Training_Id),
            Cou_Id = ISNULL(@Cou_Id, Cou_Id),
            Status = ISNULL(@Status, Status),
            TStamp = @TStamp,
            TOwner = @TOwner,
            Mandatory = ISNULL(@Mandatory, Mandatory)
        WHERE Id = @Id

        SELECT * FROM Qualification_Criteria WHERE Id = @Id
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Qualification_Criteria
        WHERE Id = @Id

        SELECT * FROM Qualification_Criteria WHERE Id = @Id
    END

END TRY
BEGIN CATCH

    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO