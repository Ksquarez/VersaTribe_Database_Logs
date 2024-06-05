CREATE TABLE [Histroy].[log_queue_extension_service] (
  [Id] [int] IDENTITY,
  [queueid] [nvarchar](4000) NULL,
  [serverip] [nvarchar](4000) NULL,
  [extension] [nvarchar](4000) NULL,
  [Service_TStamp] [dbo].[Service_TStamp] NULL,
  [Service_Response] [dbo].[Service_Response] NULL,
  [Action] [nvarchar](4000) NULL,
  CONSTRAINT [PK_log_queue_extension_service] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO