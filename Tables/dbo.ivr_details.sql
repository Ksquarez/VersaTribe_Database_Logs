CREATE TABLE [dbo].[ivr_details] (
  [ivr_id] [int] IDENTITY,
  [create_date] [datetime] NULL,
  [update_date] [datetime] NULL,
  [enabled] [bit] NULL,
  [ivr__filename] [nvarchar](max) NULL,
  [ivr_name] [nvarchar](max) NULL,
  [timeout] [int] NULL,
  [Org_Id] [int] NULL,
  CONSTRAINT [PK_ivr_details] PRIMARY KEY CLUSTERED ([ivr_id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[ivr_details]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO