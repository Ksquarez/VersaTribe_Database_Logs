CREATE TABLE [dbo].[Check_Prime_Customer] (
  [id] [bigint] IDENTITY,
  [mobile_number] [bigint] NOT NULL,
  [manager_phone] [int] NULL,
  [prime_status] [bit] NOT NULL,
  CONSTRAINT [PK_check_prime] PRIMARY KEY CLUSTERED ([id], [mobile_number])
)
ON [PRIMARY]
GO