CREATE TABLE [dbo].[Shift] (
  [Shift_Id] [int] IDENTITY,
  [Shift_Name] [nvarchar](50) NOT NULL,
  [Start_Time] [time] NOT NULL,
  [End_Time] [time] NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Shift_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  CONSTRAINT [PK_Shift] PRIMARY KEY CLUSTERED ([Shift_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Shift]
  ON [dbo].[Shift] ([Shift_Name])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create TRIGGER [dbo].[tr_ShiftActivity]
ON [dbo].[Shift]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO ShiftHistory
SELECT * FROM INSERTED
END
GO