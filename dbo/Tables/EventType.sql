CREATE TABLE [dbo].[EventType] (
    [EventTypeID] INT          IDENTITY (1, 1) NOT NULL,
    [EventType]   VARCHAR (32) NOT NULL,
    [Designator]  CHAR (1)     NOT NULL,
    CONSTRAINT [PK_EventType] PRIMARY KEY CLUSTERED ([EventTypeID] ASC),
    CONSTRAINT [UC_EventType] UNIQUE NONCLUSTERED ([EventType] ASC)
);

