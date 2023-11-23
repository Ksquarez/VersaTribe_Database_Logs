SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [dbo].[Vw_TrainingQualifications]
AS
SELECT        dbo.Qualification_Criteria.Training_Id, dbo.Qualification_Criteria.Cou_Id, dbo.Course.Cou_Name, dbo.CourseType.Ctyp_Name, dbo.Qualification_Criteria.Status, dbo.Qualification_Criteria.TStamp, 
                         dbo.Qualification_Criteria.TOwner, dbo.Qualification_Criteria.Mandatory
FROM            dbo.Qualification INNER JOIN
                         dbo.Qualification_Criteria ON dbo.Qualification.Cou_Id = dbo.Qualification_Criteria.Cou_Id INNER JOIN
                         dbo.Training ON dbo.Qualification_Criteria.Training_Id = dbo.Training.Training_Id INNER JOIN
                         dbo.Course ON dbo.Qualification.Cou_Id = dbo.Course.Cou_Id AND dbo.Qualification_Criteria.Cou_Id = dbo.Course.Cou_Id INNER JOIN
                         dbo.CourseType ON dbo.Course.CTyp_Id = dbo.CourseType.CTyp_Id
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
         Begin Table = "Qualification"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Qualification_Criteria"
            Begin Extent = 
               Top = 182
               Left = 241
               Bottom = 312
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Training"
            Begin Extent = 
               Top = 188
               Left = 645
               Bottom = 318
               Right = 815
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Course"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 136
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "CourseType"
            Begin Extent = 
               Top = 34
               Left = 942
               Bottom = 164
               Right = 1112
            End
            DisplayFlags = 280
            TopColumn = 1
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
         Or ', 'SCHEMA', N'dbo', 'VIEW', N'Vw_TrainingQualifications'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPane2', N'= 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'Vw_TrainingQualifications'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPaneCount', 2, 'SCHEMA', N'dbo', 'VIEW', N'Vw_TrainingQualifications'
GO