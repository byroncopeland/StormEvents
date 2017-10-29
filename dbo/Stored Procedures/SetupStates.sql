GO
/*==========================================================
CREATED BY:	Byron Copeland
DATE:		10.7.17
COMMENTS:	One time setup procedure for populating State table
			First step is to insert distinct states from tblstoreevents
			Second step is to update 2-letter state code
			   The state fips code for the american territories in 
			   tblstormevents is not correct, so we force the correct 
			   codes as prescribed by the NWS so the codes will match
			   up to the zonecounty table
==========================================================
UPDATED BY: Byron Copeland
DATE:       10.21.17
COMMENTS:   Fixed stateID update
==========================================================


*/
ALTER PROCEDURE [dbo].[SetupStates]

AS 

SET NOCOUNT ON

BEGIN TRY
	BEGIN TRANSACTION

	-- Grab states from raw tblStoreEvents using fips and state name which is full
	INSERT dbo.States (StateID, stateName)
	SELECT DISTINCT CAST(state_fips AS INT), state
	  FROM tblStormEvents se
	       LEFT JOIN dbo.states s ON s.StateName = se.STATE 
	 WHERE s.StateName is NULL     
	 ORDER BY cast(state_fips as int);

	--Update States.StateCode from zonecounty table
	--The American territories Fips code have to be hard-coded
	WITH CTE AS (
	 select distinct state, 
	 CASE when state =  'Virgin Islands' then 78
		  WHEN state ='American Samoa' then 60
		  WHEN  state ='Guam' THEN 66
		  WHEN  state ='PUERTO RICO' THEN 72
		  ELSE state_fips 
		  END AS state_fips
		  from tblstormevents) --full state names

	UPDATE dbo.states 
	   SET StateCode = zc.state, stateID = se.state_fips --added stateID 10.21.17
	  FROM dbo.states s
		   INNER JOIN CTE se on s.statename = se.State
		   INNER JOIN zonecounty zc on cast(left(zc.fips,2) AS INT) = se.STATE_FIPS

	COMMIT TRANSACTION

END TRY


BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   ;THROW
   RETURN 1
END CATCH