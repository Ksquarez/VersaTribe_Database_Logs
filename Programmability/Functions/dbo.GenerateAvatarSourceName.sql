SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[GenerateAvatarSourceName] (@FirstName NVARCHAR(MAX), @LastName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @AvatarSourceName NVARCHAR(MAX);
    SET @AvatarSourceName = UPPER(LEFT(@FirstName, 1)) + UPPER(LEFT(@LastName, 1));
    RETURN @AvatarSourceName;
END;
GO