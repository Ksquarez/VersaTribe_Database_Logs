SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spCourse_JsonModel]
(
  @Cou_Id INT = NULL,
  @Cou_Name NVARCHAR(256) = NULL,
  @CTyp_Id INT = NULL,
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
        FROM Course
        WHERE (@Cou_Id IS NULL OR Cou_Id = @Cou_Id)
            AND (@Cou_Name IS NULL OR Cou_Name = @Cou_Name)
            AND (@CTyp_Id IS NULL OR CTyp_Id = @CTyp_Id)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
			FOR JSON  AUTO, INCLUDE_NULL_VALUES
    END
	 ELSE IF @Action = 'JOIN_CourseType'
    BEGIN
        SELECT Course.*,
		(SELECT CourseType.CTyp_Id, CourseType.Ctyp_Name FROM CourseType WHERE CourseType.CTyp_Id = Course.CTyp_Id
		FOR JSON AUTO
		) AS CourseType
        FROM Course
        WHERE (@Cou_Id IS NULL OR Cou_Id = @Cou_Id)
            AND (@Cou_Name IS NULL OR Cou_Name = @Cou_Name)
            AND (@CTyp_Id IS NULL OR CTyp_Id = @CTyp_Id)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
			FOR JSON  AUTO, INCLUDE_NULL_VALUES

    END
	-- api/Courses/GetListPaging/?pageSize=10&pageNumber=1
	 ELSE IF @Action = 'api/Courses/GetListPaging'
    BEGIN
		
	DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
        SELECT 
		Course.*
		FROM
		Course
		ORDER BY Course.Cou_Name 
		OFFSET @Offset ROWS
        FETCH NEXT @PageSize ROWS ONLY
		FOR JSON PATH, INCLUDE_NULL_VALUES

    END
	

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO