CREATE TABLE [dbo].[ivr_entries] (
  [id] [bigint] IDENTITY,
  [ivr_id] [bigint] NOT NULL,
  [selection] [nvarchar](20) NOT NULL,
  [destination] [nvarchar](50) NULL,
  [destination_type] [nvarchar](40) NOT NULL DEFAULT (''),
  CONSTRAINT [PK_ivr_entries_id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ivr_entries]
  ADD CONSTRAINT [FK_ivr_entries_ivr_id] FOREIGN KEY ([ivr_id]) REFERENCES [dbo].[ivr_details] ([ivr_id])
GO