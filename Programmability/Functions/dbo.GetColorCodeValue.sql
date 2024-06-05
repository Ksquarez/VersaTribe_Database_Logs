SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[GetColorCodeValue] (@FirstName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @ColorCodeValue NVARCHAR(MAX);
    SELECT @ColorCodeValue = cc.ColorCodeValue
    FROM MasterTable.ColorCode cc
    WHERE cc.Name = LEFT(@FirstName, 1);
    RETURN @ColorCodeValue;
END;
GO