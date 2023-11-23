CREATE TABLE [dbo].[ivr_details] (
  [ivr_id] [bigint] IDENTITY (1000001, 1),
  [create_date] [datetime] NULL,
  [update_dat] [datetime] NULL,
  [enabled] [bit] NOT NULL,
  [ivr__filename] [nvarchar](80) NULL,
  [ivr_name] [nvarchar](80) NULL,
  [timeout] [int] NULL,
  CONSTRAINT [PK_ivr_details] PRIMARY KEY CLUSTERED ([ivr_id])
)
ON [PRIMARY]
GO