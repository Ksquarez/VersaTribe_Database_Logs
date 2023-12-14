SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [dbo].[Vw_OrgPersons]
AS
SELECT        dbo.Org.Org_Id, dbo.Org.Org_Name, dbo.Person.Person_Id, dbo.Person.FirstName, dbo.Person.LastName, dbo.Person.TOwner AS Email, dbo.Department.Dept_Name, dbo.OrgPerson.Request_Status, 
                         (CASE WHEN OrgPerson.Request_Status = 1 THEN 'APPROVED' WHEN OrgPerson.Request_Status = 0 THEN 'REQUESTED' WHEN OrgPerson.Request_Status = - 1 THEN 'REJECTED' WHEN OrgPerson.Request_Status = - 2 THEN
                          'REMOVED' ELSE NULL END) AS Request_Status_Str, dbo.OrgPerson.IsCaller, dbo.OrgPerson.Is_Default, dbo.OrgPerson.TOwner, dbo.OrgPerson.TStamp, dbo.OrgPerson.Status, dbo.OrgPerson.Dept_Req
FROM            dbo.OrgPerson INNER JOIN
                         dbo.Person ON dbo.Person.Person_Id = dbo.OrgPerson.Person_Id INNER JOIN
                         dbo.Org ON dbo.Org.Org_Id = dbo.OrgPerson.Org_Id INNER JOIN
                         dbo.Department ON dbo.Department.Dept_Id = dbo.OrgPerson.Dept_Id
WHERE        (dbo.OrgPerson.Request_Status = 1)
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
         Begin Table = "OrgPerson"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "Person"
            Begin Extent = 
               Top = 7
               Left = 572
               Bottom = 137
               Right = 742
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Org"
            Begin Extent = 
               Top = 179
               Left = 249
               Bottom = 309
               Right = 419
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Department"
            Begin Extent = 
               Top = 186
               Left = 687
               Bottom = 316
               Right = 857
            End
            DisplayFlags = 280
            TopColumn = 0
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
', 'SCHEMA', N'dbo', 'VIEW', N'Vw_OrgPersons'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'dbo', 'VIEW', N'Vw_OrgPersons'
GO