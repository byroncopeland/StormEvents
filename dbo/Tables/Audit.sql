CREATE TABLE [dbo].[Audit] (
    [AuditKey]                INT          IDENTITY (1, 1) NOT NULL,
    [ParentAuditKey]          INT          NOT NULL,
    [TableName]               VARCHAR (50) DEFAULT ('Unknown') NOT NULL,
    [PkgName]                 VARCHAR (50) DEFAULT ('Unknown') NOT NULL,
    [ExecStartDT]             DATETIME     DEFAULT (getdate()) NOT NULL,
    [ExecStopDT]              DATETIME     NULL,
    [ExtractRowCnt]           BIGINT       NULL,
    [InsertRowCnt]            BIGINT       NULL,
    [UpdateRowCnt]            BIGINT       NULL,
    [ErrorRowCnt]             BIGINT       NULL,
    [TableInitialRowCnt]      BIGINT       NULL,
    [TableFinalRowCnt]        BIGINT       NULL,
    [TableMaxDateTime]        DATETIME     NULL,
    [SuccessfulProcessingInd] CHAR (1)     DEFAULT ('N') NOT NULL,
    CONSTRAINT [PK_dbo.Audit] PRIMARY KEY CLUSTERED ([AuditKey] ASC)
);

