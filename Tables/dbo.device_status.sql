CREATE TABLE [dbo].[device_status] (
  [id] [bigint] IDENTITY,
  [device] [nvarchar](255) NOT NULL,
  [status] [nvarchar](50) NULL,
  CONSTRAINT [PK_device_status] PRIMARY KEY CLUSTERED ([id], [device]),
  CONSTRAINT [UK_device_status_device] UNIQUE ([device])
)
ON [PRIMARY]
GO