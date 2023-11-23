CREATE TABLE [dbo].[AspNetUserClaims] (
  [Id] [int] IDENTITY,
  [UserId] [nvarchar](128) NOT NULL,
  [ClaimType] [nvarchar](max) NULL,
  [ClaimValue] [nvarchar](max) NULL,
  CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE INDEX [IX_UserId]
  ON [dbo].[AspNetUserClaims] ([UserId])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[AspNetUserClaims]
  ADD CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
GO