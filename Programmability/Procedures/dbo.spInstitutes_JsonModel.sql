SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spInstitutes_JsonModel]
(
  @Inst_Id INT = NULL,
  @Inst_Name NVARCHAR(50) = NULL,
  @Inst_Type NVARCHAR(50) = NULL,
  @City NVARCHAR(50) = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Status INT = NULL,
  @PageSize INT = NULL,
  @PageNumber INT = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Institutes
        WHERE (@Inst_Id IS NULL OR Inst_Id = @Inst_Id)
            AND (@Inst_Name IS NULL OR Inst_Name = @Inst_Name)
            AND (@Inst_Type IS NULL OR Inst_Type = @Inst_Type)
			AND (@City IS NULL OR City = @City)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
			FOR JSON  AUTO, INCLUDE_NULL_VALUES
    END
	 
	-- api/Institutes/GetListPaging/?pageSize=10&pageNumber=1
	ELSE IF @Action = 'api/Institutes/GetListPaging'
    BEGIN
		
		DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
			SELECT Institutes.* FROM
			Institutes
			ORDER BY Institutes.Inst_Name
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