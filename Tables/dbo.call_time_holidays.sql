CREATE TABLE [dbo].[call_time_holidays] (
  [holiday_id] [int] IDENTITY,
  [holiday_name] [nvarchar](max) NOT NULL,
  [holiday_comments] [nvarchar](max) NULL,
  [holiday_date] [date] NULL,
  [holiday_status] [nvarchar](max) NULL,
  [ct_default_start] [smallint] NOT NULL,
  [ct_default_stop] [smallint] NOT NULL,
  [default_afterhours_filename_override] [nvarchar](max) NULL,
  [user_group] [nvarchar](max) NULL,
  [Org_Id] [int] NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO