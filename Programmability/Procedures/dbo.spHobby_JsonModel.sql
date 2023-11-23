SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spHobby_JsonModel]
(
  @Hobby_Id INT = NULL,
  @Name NVARCHAR(50) = NULL,
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
        FROM Hobby
        WHERE   (@Hobby_Id IS NULL OR Hobby_Id = @Hobby_Id)
            AND (@Name IS NULL OR Name = @Name)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
		FOR JSON Auto, INCLUDE_NULL_VALUES	
    END
	  ELSE IF @Action = 'api/Hobby/GetListPaging'
    BEGIN
		
	DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
        SELECT 
		Hobby.*
		FROM
		Hobby
		ORDER BY Hobby.Name 
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