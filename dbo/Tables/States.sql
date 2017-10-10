CREATE TABLE [dbo].[States] (
    [StateID]   INT          NOT NULL,
    [StateName] VARCHAR (50) NOT NULL,
    [StateCode] CHAR (2)     NULL,
    CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED ([StateID] ASC)
);

