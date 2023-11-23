﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spSessionUrlLayout]

AS
Begin Try

	WITH RecursiveURLs AS (
    SELECT
        URLID,
        ParentURLID,
        URLPath,
        URLName,
		URLOrder
    FROM URLs
    WHERE ParentURLID IS NULL
 
    UNION ALL
    
    SELECT
        u.URLID,
        u.ParentURLID,
        u.URLPath,
		u.URLName,
		u.URLOrder
    FROM RecursiveURLs r
    INNER JOIN URLs u ON r.URLID = u.ParentURLID
	
)
SELECT
    URLs.URLPath,URLs.URLName,URLs.URLOrder,
    (
        SELECT ChildURLs.URLPath,ChildURLs.URLName,ChildURLs.URLOrder
        FROM RecursiveURLs ChildURLs
        WHERE ChildURLs.ParentURLID = URLs.URLID
		ORDER BY ChildURLs.URLOrder ASC
        FOR JSON AUTO
    ) AS ChildURLs
FROM RecursiveURLs URLs
WHERE URLs.ParentURLID IS NULL
ORDER BY URLs.URLOrder ASC
FOR JSON AUTO

End Try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO