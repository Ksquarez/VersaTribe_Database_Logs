SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [Person].[Vw_PersonQualification]
AS
SELECT        dbo.Course.Cou_Name, dbo.PersonQualification.PQ_Id, dbo.PersonQualification.QI_Id, dbo.PersonQualification.Person_Id, dbo.PersonQualification.YOP, dbo.PersonQualification.Grade, dbo.PersonQualification.Status, 
                         dbo.PersonQualification.TOwner, dbo.PersonQualification.TStamp, dbo.PersonQualification.City, dbo.Qualification.Cou_Id, dbo.Qualification.Inst_Id, dbo.Institutes.Inst_Name, dbo.Institutes.Inst_Type, 
                         dbo.CourseType.Ctyp_Name, dbo.Course.CTyp_Id
FROM            dbo.Institutes INNER JOIN
                         dbo.Course INNER JOIN
                         dbo.CourseType ON dbo.Course.CTyp_Id = dbo.CourseType.CTyp_Id INNER JOIN
                         dbo.PersonQualification INNER JOIN
                         dbo.Person ON dbo.PersonQualification.Person_Id = dbo.Person.Person_Id INNER JOIN
                         dbo.Qualification ON dbo.PersonQualification.QI_Id = dbo.Qualification.QI_Id ON dbo.Course.Cou_Id = dbo.Qualification.Cou_Id ON dbo.Institutes.Inst_Id = dbo.Qualification.Inst_Id
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[46] 4[15] 2[20] 3) )"
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
         Begin Table = "Institutes"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Course"
            Begin Extent = 
               Top = 6
               Left = 405
               Bottom = 136
               Right = 575
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CourseType"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PersonQualification"
            Begin Extent = 
               Top = 65
               Left = 798
               Bottom = 195
               Right = 968
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Person"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "Qualification"
            Begin Extent = 
               Top = 220
               Left = 594
               Bottom = 350
               Right = 764
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
         Column = ', 'SCHEMA', N'Person', 'VIEW', N'Vw_PersonQualification'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPane2', N'1440
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
', 'SCHEMA', N'Person', 'VIEW', N'Vw_PersonQualification'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPaneCount', 2, 'SCHEMA', N'Person', 'VIEW', N'Vw_PersonQualification'
GO