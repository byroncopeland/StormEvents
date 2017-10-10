CREATE PROCEDURE [StormeventsCorrectTypeUpdate] 

AS

SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRY;
	DECLARE @typefix TABLE (event_type varchar(32), cz_type char(1), tcount int);

/*-------------------------------------------------------------------------------
  Get events in tblstoreevents with more than one cz_type
-------------------------------------------------------------------------------*/
	WITH CTE AS (
		SELECT DISTINCT event_type, cz_type 
		  FROM tblStormEvents
		)
		INSERT @typefix (event_type, cz_type, tcount)
		SELECT event_type, cz_type, count(*) AS tcount
		  FROM tblStormEvents
		 WHERE event_type IN 
			   (SELECT event_type 
				  FROM CTE
				 GROUP BY event_type 
				HAVING count(*) > 1) --this will give you only the events with multi types
		 GROUP BY EVENT_TYPE, cz_type 
		 ORDER BY EVENT_TYPE, tcount;

	/* create variables */
	DECLARE @row int=1, @rows int, @cztype char(1)
	DECLARE @typetable TABLE (
		idnum INT IDENTITY,
		event_type VARCHAR(32), 
		tcount INT);

/*----------------------------------------------------------------------------
 UPDATE the bad types in tblstormevents
----------------------------------------------------------------------------*/

	BEGIN TRANSACTION;
	WITH CTE AS (
		SELECT DISTINCT event_type --get one of each event
		  FROM @typefix
		)
		INSERT @typetable (event_type, tcount) --Store the max tcount for each event with bad types
		SELECT t.event_type, max(tcount)       --This will have the correct type
		  FROM @typefix t
			   INNER JOIN CTE c 
			   ON c.EVENT_TYPE = t.event_type
		 GROUP BY t.EVENT_TYPE;

		SET @rows = @@rowcount;
		/* Loop thru event_types that had incorrect cz_type descriptors */
		WHILE @row <= @rows
		BEGIN
		/* Get correct type C or Z for the event */
			SELECT @cztype = t1.cz_type 
			  FROM @typefix AS t1
				   INNER JOIN @typetable AS t2 
				   ON t2.event_type = t1.EVENT_TYPE 
					  AND t1.tcount = t2.tcount
			 WHERE t2.idnum = @row;
	
		/* Update tblStoreEvents raw table events with correct cz_type */
			UPDATE tblStormEvents
			   SET CZ_TYPE = @cztype 
			  FROM tblStormEvents AS se
				   INNER JOIN @typetable AS t2 
				   ON se.EVENT_TYPE = t2.event_type 
			 WHERE idnum = @row 
			AND se.CZ_TYPE <> @cztype; --pick selected records with wrong type

			SET @row = @row + 1;
		END;
		COMMIT TRANSACTION;
END TRY

BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   ;THROW
   RETURN 1
END CATCH 