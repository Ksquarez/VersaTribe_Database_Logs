SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create Proc [dbo].[spQual_CRUD]
(
  @QI_Id int = NULL,
  @Cou_Id int = NULL,
  @Inst_Id int = NULL,
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
        SELECT * FROM Qualification
        WHERE   (@QI_Id IS NULL OR QI_Id = @QI_Id)
				AND (@Cou_Id IS NULL OR Cou_Id = @Cou_Id)
				AND (@Inst_Id IS NULL OR Inst_Id = @Inst_Id)
				AND (@TStamp IS NULL OR TStamp = @TStamp)
				AND (@TOwner IS NULL OR TOwner = @TOwner)
				AND (@Status IS NULL OR Status = @Status)
		END
	ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Qualification (Cou_Id,Inst_Id, Status,TStamp,TOwner)
        VALUES (@Cou_Id,@Inst_Id, @Status, @TStamp, @TOwner)

		SELECT * FROM Qualification WHERE QI_Id = SCOPE_IDENTITY();
    END

	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Qualification
        SET Cou_Id = ISNULL(@Cou_Id,Cou_Id),
			Inst_Id = ISNULL(@Inst_Id,Inst_Id),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE QI_Id = @QI_Id

		SELECT * FROM Qualification WHERE QI_Id = @QI_Id;
	END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Qualification
        WHERE QI_Id = @QI_Id
		SELECT * FROM Qualification
        WHERE QI_Id = @QI_Id
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO