SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [Asterisk].[Vw_Extensions]
AS
SELECT        dbo.Person.FirstName, dbo.Person.LastName, dbo.Person.TOwner AS PersonEmail, dbo.Org.Org_Name, dbo.Org.OrgAdmin_Id, dbo.Extensions.Extension_Id, dbo.Extensions.Org_Id, dbo.Extensions.Person_Id, 
                         dbo.Extensions.Extension_Srv_Id, dbo.Extensions.Srv_Id, dbo.Extensions.UserName, dbo.Extensions.Secret, dbo.Extensions.Transport, dbo.Extensions.TStamp, dbo.Extensions.TOwner, dbo.Extensions.Service_TStamp, 
                         dbo.Extensions.Service_Response, dbo.Extensions.Status, dbo.Extensions.Entity_TStamp, dbo.OrgPerson.Dept_Id, dbo.OrgPerson.IsCaller, dbo.OrgPerson.Is_Default, 
                         (CASE WHEN OrgPerson.Request_Status = 1 THEN 'APPROVED' WHEN OrgPerson.Request_Status = 0 THEN 'REQUESTED' WHEN OrgPerson.Request_Status = - 1 THEN 'REJECTED' WHEN OrgPerson.Request_Status = - 2 THEN
                          'REMOVED' ELSE NULL END) AS Request_Status_Str, dbo.OrgPerson.Request_Status
FROM            dbo.Extensions INNER JOIN
                         dbo.Org ON dbo.Extensions.Org_Id = dbo.Org.Org_Id INNER JOIN
                         dbo.OrgPerson ON dbo.Org.Org_Id = dbo.OrgPerson.Org_Id INNER JOIN
                         dbo.Person ON dbo.Extensions.Person_Id = dbo.Person.Person_Id AND dbo.OrgPerson.Person_Id = dbo.Person.Person_Id
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Extensions"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 319
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Org"
            Begin Extent = 
               Top = 6
               Left = 257
               Bottom = 226
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OrgPerson"
            Begin Extent = 
               Top = 3
               Left = 561
               Bottom = 301
               Right = 911
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Person"
            Begin Extent = 
               Top = 238
               Left = 305
               Bottom = 368
               Right = 475
            End
            DisplayFlags = 280
            TopColumn = 7
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'Asterisk', 'VIEW', N'Vw_Extensions'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'Asterisk', 'VIEW', N'Vw_Extensions'
GO