CREATE TABLE [dbo].[County] (
    [CountyID]   INT          IDENTITY (1, 1) NOT NULL,
    [CountyName] VARCHAR (50) NOT NULL,
    [StateID]    INT          NOT NULL,
    [CountyFIPS] INT          NOT NULL,
    CONSTRAINT [PK_County] PRIMARY KEY CLUSTERED ([CountyID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_County_CountyName]
    ON [dbo].[County]([CountyName] ASC);

