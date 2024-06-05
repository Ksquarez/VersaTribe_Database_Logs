CREATE TABLE [Histroy].[log_extension_service] (
  [Id] [int] IDENTITY,
  [extension] [nvarchar](4000) NULL,
  [secret] [nvarchar](4000) NULL,
  [transport] [nvarchar](4000) NULL,
  [serverip] [nvarchar](4000) NULL,
  [name] [nvarchar](4000) NULL,
  [Service_Response] [dbo].[Service_Response] NULL,
  [Service_TStamp] [dbo].[Service_TStamp] NULL,
  [Action] [nvarchar](4000) NULL
)
ON [PRIMARY]
GO