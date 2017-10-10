/* 
==========================================================
CREATED BY:	Byron Copeland
DATE:		10.7.17
COMMENTS:	List Storm Events By CountyID
==========================================================
EXEC dbo.StormeventsListByCounty 48, 83

*/

CREATE PROCEDURE dbo.StormeventsListByCounty @StateID INT, @CountyID int
AS

SELECT se.EventID, et.EventType, se.BeginDateTime 
  FROM dbo.StormEvents AS se
	   INNER JOIN dbo.Location as l
	   ON l.LocationID = se.LocationID 
	   INNER JOIN dbo.County as c 
	   ON c.CountyID = l.CountyID
	   INNER Join dbo.EventType AS et
	   ON se.EventTypeID = et.EventTypeID
 WHERE c.StateID = @StateID
   AND c.CountyID = @CountyID 
 ORDER BY se.BeginDateTime
 