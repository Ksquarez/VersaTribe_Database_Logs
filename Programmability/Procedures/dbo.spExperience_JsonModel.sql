SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spExperience_JsonModel]
(
  @Exp_Id INT = NULL,
  @Company_Name NVARCHAR(50) = NULL,
  @Industry_Field_Name NVARCHAR(50) = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Status INT = NULL,
  @PageSize INT = NULL,
  @PageNumber INT = NULL,
  @Action NVARCHAR(MAX)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
       SELECT *
        FROM Experience
        WHERE (@Exp_Id IS NULL OR Exp_Id = @Exp_Id)
            AND (@Company_Name IS NULL OR Company_Name = @Company_Name)
            AND (@Industry_Field_Name IS NULL OR Industry_Field_Name = @Industry_Field_Name)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
			FOR JSON PATH, INCLUDE_NULL_VALUES
    END
	  ELSE IF @Action = 'api/Experience/GetListPaging'
    BEGIN
		
	DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
        SELECT 
		Experience.*
		FROM
		Experience
		ORDER BY Experience.Company_Name 
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