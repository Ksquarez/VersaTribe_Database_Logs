SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [Histroy].[Vw_Asterisk_Extensions_Exclude_Duplication]
AS
SELECT        A.Extension_Id, A.Org_Id, A.Person_Id, A.Extension_Srv_Id, A.UserName, A.Secret, A.Srv_Id, CONCAT(P.FirstName,' ',P.LastName) AS PersonName
FROM            Histroy.Asterisk_Extensions AS A
INNER JOIN dbo.Person AS P ON P.Person_Id = A.Person_Id
WHERE A.Extension_Srv_Id IS NOT NULL AND A.Extension_Srv_Id != ''
GROUP BY  A.Extension_Id, A.Org_Id, A.Person_Id, A.Extension_Srv_Id, A.UserName, A.Secret, A.Srv_Id, CONCAT(P.FirstName,' ',P.LastName);
GO