SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [Asterisk].[Vw_call_times]
AS
SELECT        dbo.Org.Org_Name, dbo.Org.OrgAdmin_Id, dbo.call_times.call_time_id, dbo.call_times.call_time_name, dbo.call_times.call_time_comments, dbo.call_times.ct_default_start, dbo.call_times.ct_default_stop, 
                         dbo.call_times.ct_sunday_start, dbo.call_times.ct_sunday_stop, dbo.call_times.ct_monday_start, dbo.call_times.ct_monday_stop, dbo.call_times.ct_tuesday_start, dbo.call_times.ct_tuesday_stop, 
                         dbo.call_times.ct_wednesday_start, dbo.call_times.ct_wednesday_stop, dbo.call_times.ct_thursday_start, dbo.call_times.ct_thursday_stop, dbo.call_times.ct_friday_start, dbo.call_times.ct_friday_stop, 
                         dbo.call_times.ct_saturday_start, dbo.call_times.ct_saturday_stop, dbo.call_times.ct_state_call_times, dbo.call_times.default_afterhours_filename_override, dbo.call_times.sunday_afterhours_filename_override, 
                         dbo.call_times.monday_afterhours_filename_override, dbo.call_times.tuesday_afterhours_filename_override, dbo.call_times.wednesday_afterhours_filename_override, dbo.call_times.thursday_afterhours_filename_override, 
                         dbo.call_times.friday_afterhours_filename_override, dbo.call_times.saturday_afterhours_filename_override, dbo.call_times.user_group, dbo.call_times.Org_Id, dbo.call_times.ct_holidays
FROM            dbo.call_times INNER JOIN
                         dbo.Org ON dbo.call_times.Org_Id = dbo.Org.Org_Id
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
         Begin Table = "call_times"
            Begin Extent = 
               Top = 16
               Left = 645
               Bottom = 146
               Right = 951
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Org"
            Begin Extent = 
               Top = 30
               Left = 290
               Bottom = 160
               Right = 460
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
', 'SCHEMA', N'Asterisk', 'VIEW', N'Vw_call_times'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'Asterisk', 'VIEW', N'Vw_call_times'
GO