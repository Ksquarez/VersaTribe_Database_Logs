SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spCouTyp_JsonModel]
(
   @CTyp_Id INT = NULL,
   @Ctyp_Name NVARCHAR(50) = NULL,
   @Status INT = NULL,
   @TStamp DATETIME2(7) = NULL,
   @TOwner NVARCHAR(256) = NULL,
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
        FROM CourseType
        WHERE   (@CTyp_Id IS NULL OR CTyp_Id = @CTyp_Id)
            AND (@Ctyp_Name IS NULL OR Ctyp_Name = @Ctyp_Name)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			FOR JSON  AUTO, INCLUDE_NULL_VALUES
    END
	 ELSE IF @Action = 'JOIN_CourseType'
    BEGIN
        SELECT CourseType.*,
		       (SELECT Course.Cou_Id,Course.Cou_Name FROM Course WHERE Course.CTyp_Id = CourseType.CTyp_Id
			   FOR JSON AUTO) AS Courses
        FROM CourseType
        WHERE   (@CTyp_Id IS NULL OR CTyp_Id = @CTyp_Id)
            AND (@Ctyp_Name IS NULL OR Ctyp_Name = @Ctyp_Name)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			FOR JSON  AUTO, INCLUDE_NULL_VALUES

    END
	-- api/CourseTypes/GetListPaging/?pageSize=10&pageNumber=1
	 ELSE IF @Action = 'api/CourseTypes/GetListPaging'
    BEGIN
		
	DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
        SELECT 
		CourseType.*
		FROM
		CourseType
		ORDER BY CourseType.Ctyp_Name 
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