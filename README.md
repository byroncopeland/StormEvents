# StormEvents SQL DB
A SQL project using storm event .csv files from noaa.gov and converting to a normalized database.
The event files are available from:
ftp://ftp.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/

To develop the database, we use the StormEvents detail files.
Each .csv file was inserted using SSIS into the raw working table, tblStormEvents.

To get zone and county details and correlations, we pull data from:
https://www.weather.gov/source/gis/Shapefiles/County/bp01nv16.dbx



