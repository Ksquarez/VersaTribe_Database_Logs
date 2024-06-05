CREATE TABLE [Histroy].[log_did_service] (
  [Id] [int] IDENTITY,
  [serverip] [nvarchar](4000) NULL,
  [did] [nvarchar](4000) NULL,
  [Service_Response] [dbo].[Service_Response] NULL,
  [Service_TStamp] [dbo].[Entity_TStamp] NULL,
  [Action] [nvarchar](4000) NULL,
  CONSTRAINT [PK_log_did_service] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO