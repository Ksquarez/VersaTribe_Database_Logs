CREATE TABLE [dbo].[ivr_details] (
  [ivr_id] [int] IDENTITY,
  [create_date] [datetime] NULL,
  [update_date] [datetime] NULL,
  [enabled] [bit] NULL,
  [ivr_files_Id] [int] NULL,
  [ivr_name] [nvarchar](200) NULL,
  [timeout] [int] NULL,
  [Org_Id] [int] NULL,
  [TStamp] [datetime] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Status] [int] NULL,
  [ivr_id_str] [nvarchar](14) NULL,
  CONSTRAINT [PK_ivr_details] PRIMARY KEY CLUSTERED ([ivr_id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UK_ivr_details]
  ON [dbo].[ivr_details] ([ivr_name], [Org_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[ivr_details] WITH NOCHECK
  ADD FOREIGN KEY ([ivr_files_Id]) REFERENCES [dbo].[Org_Files] ([Id]) ON DELETE SET NULL
GO

ALTER TABLE [dbo].[ivr_details]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO