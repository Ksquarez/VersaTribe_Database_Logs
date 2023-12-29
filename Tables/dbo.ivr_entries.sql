CREATE TABLE [dbo].[ivr_entries] (
  [id] [bigint] IDENTITY,
  [ivr_id] [int] NULL,
  [selection] [nvarchar](20) NULL,
  [destination] [nvarchar](50) NULL,
  [destination_type] [nvarchar](40) NULL,
  CONSTRAINT [PK_ivr_entries_id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ivr_entries]
  ADD FOREIGN KEY ([ivr_id]) REFERENCES [dbo].[ivr_details] ([ivr_id])
GO