﻿/*==========================================================
CREATED BY:	Byron Copeland
DATE:		10.9.17
COMMENTS:	Populate counties by state
			 
==========================================================

*/
CREATE PROCEDURE [dbo].[SetupCounty]
AS

SET NOCOUNT ON;
BEGIN TRY
	BEGIN TRANSACTION;
---------------------------------------------------------
-- COUNTY 
--------------------------------------------------------- 
	-- In raw table zonecountry, fips is concentatation of StateID and County FIPS
	INSERT [dbo].[County]
		   (CountyName,
		   StateID,
		   CountyFIPS) 
	SELECT DISTINCT 
	       county, 
		   left(fips,2), 
		   right(fips,3)
	  FROM zonecounty

	COMMIT TRANSACTION;
END TRY

BEGIN CATCH
IF @@trancount > 0 ROLLBACK TRANSACTION
   ;THROW
   RETURN 1
END CATCH
GO

