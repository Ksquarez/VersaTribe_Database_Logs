SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [Training].[Vw_Training_Join]
AS
SELECT        dbo.Training_Join.Training_Id, dbo.Training_Join.Person_Id, dbo.Training_Join.Is_Join, dbo.Training_Join.Joined_At, dbo.Training_Join.Status, dbo.Training_Join.TStamp, dbo.Training_Join.TOwner, dbo.Org.Org_Name, 
                         dbo.Org.OrgAdmin_Id, dbo.Training.Training_Name, dbo.Person.FirstName, dbo.Person.LastName, dbo.Person.TOwner AS 'PersonEmail'
FROM            dbo.Person INNER JOIN
                         dbo.Training_Join ON dbo.Person.Person_Id = dbo.Training_Join.Person_Id INNER JOIN
                         dbo.Training ON dbo.Training_Join.Training_Id = dbo.Training.Training_Id INNER JOIN
                         dbo.Org ON dbo.Training.Org_Id = dbo.Org.Org_Id

GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[13] 2[20] 3) )"
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
         Begin Table = "Person"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "Training"
            Begin Extent = 
               Top = 106
               Left = 457
               Bottom = 388
               Right = 722
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Training_Join"
            Begin Extent = 
               Top = 0
               Left = 753
               Bottom = 130
               Right = 923
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Org"
            Begin Extent = 
               Top = 120
               Left = 232
               Bottom = 250
               Right = 402
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
', 'SCHEMA', N'Training', 'VIEW', N'Vw_Training_Join'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'Training', 'VIEW', N'Vw_Training_Join'
GO