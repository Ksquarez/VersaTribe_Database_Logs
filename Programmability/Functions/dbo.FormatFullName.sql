SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[FormatFullName] (@FirstName NVARCHAR(MAX), @LastName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @FullName NVARCHAR(MAX);
    SET @FullName = CONCAT(
                        UPPER(LEFT(@FirstName, 1)), LOWER(SUBSTRING(@FirstName, 2, LEN(@FirstName))),
                        ' ',
                        UPPER(LEFT(@LastName, 1)), LOWER(SUBSTRING(@LastName, 2, LEN(@LastName)))
                    );
    RETURN @FullName;
END;
GO