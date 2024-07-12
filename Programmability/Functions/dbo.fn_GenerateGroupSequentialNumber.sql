SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fn_GenerateGroupSequentialNumber](@Srv_Id INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @uniqueNumber NVARCHAR(13);
    DECLARE @startNum NVARCHAR(MAX);

  --  -- Get the initial value from the Servers table
  --  SELECT @startNum = CAST(Group_Start_Num AS NVARCHAR(MAX)) FROM Servers WHERE Srv_Id = @Srv_Id;

  --  DECLARE @timestamp NVARCHAR(50);

	 ---- Get current timestamp as a string
  --  SET @timestamp =  FORMAT(GETUTCDATE(), 'ddMMyymmss');


  --  -- Combine prefix, timestamp
  --  SET @uniqueNumber = @startNum + @timestamp;

  --  -- Adjust if the length is shorter than 13 characters
  --  SET @uniqueNumber = @uniqueNumber + REPLICATE('0', 13 - LEN(@uniqueNumber));

  --  -- Truncate if the combined string exceeds 13 characters
  --  SET @uniqueNumber = LEFT(@uniqueNumber, 13);

	RETURN @uniqueNumber;
END;
GO