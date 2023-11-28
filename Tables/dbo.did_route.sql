CREATE TABLE [dbo].[did_route] (
  [id] [bigint] IDENTITY,
  [did] [bigint] NOT NULL,
  [description] [nvarchar](255) NOT NULL,
  [route_type] [nvarchar](10) NOT NULL,
  [route_id] [nvarchar](10) NOT NULL,
  [create_date] [datetime] NULL,
  [update_date] [datetime] NULL,
  [enabled] [bit] NOT NULL DEFAULT (0),
  [Org_Id] [int] NULL,
  [call_time_id] [int] NULL,
  CONSTRAINT [PK_did_route] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO