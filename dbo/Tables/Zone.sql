CREATE TABLE [dbo].[Zone] (
    [zoneID]    INT           IDENTITY (1, 1) NOT NULL,
    [zoneName]  VARCHAR (132) NOT NULL,
    [StateZone] CHAR (5)      NOT NULL,
    [StateCode] CHAR (2)      NOT NULL,
    [Zone]      INT           NOT NULL,
    CONSTRAINT [PK_Zone] PRIMARY KEY CLUSTERED ([zoneID] ASC)
);

