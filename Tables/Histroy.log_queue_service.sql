CREATE TABLE [Histroy].[log_queue_service] (
  [Id] [int] IDENTITY,
  [queueid] [nvarchar](4000) NULL,
  [serverip] [nvarchar](4000) NULL,
  [strategy] [nvarchar](4000) NULL,
  [timeout] [nvarchar](4000) NULL,
  [group_name] [nvarchar](4000) NULL,
  [Service_TStamp] [dbo].[Service_TStamp] NULL,
  [Service_Response] [dbo].[Service_Response] NULL,
  [Action] [nvarchar](4000) NULL,
  CONSTRAINT [PK_log_queue_service] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO