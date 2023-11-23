CREATE TABLE [dbo].[Refresh_Tokens] (
  [Id] [int] IDENTITY,
  [TOwner] [nvarchar](256) NOT NULL,
  [RefreshToken] [varchar](max) NOT NULL,
  [RT_Expiry] [datetime] NOT NULL,
  [Expire_in_sec] [int] NOT NULL,
  [Issue] [datetime] NOT NULL,
  [AT_Expiry] [datetime] NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Refresh_Tokens_Status] DEFAULT (0),
  CONSTRAINT [PK_Refresh_Tokens] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Refresh_Tokens]
  ADD CONSTRAINT [FK_Refresh_Tokens_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO