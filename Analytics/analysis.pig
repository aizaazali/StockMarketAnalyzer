-- This program takes input file which contains values stored in the format "yymmdd_articlenumber.txt sentimentvalue". 
-- For example, "20160301_12.txt 0.23432".
-- This pigscript is used to find the average of all the sentiment values for a particular day.
-- The output is in the format "yymmdd sentimentvalueofallarticles". 
-- For example, "20160211 0.234" is the sentiment value for all articles of 02/11/2016.

-- Load input data
readinput = LOAD '/user/cloudera/amzn_results.csv' using PigStorage(',') AS (year:chararray, textval:double);

-- Split date and (articlenumber+fileextension)
finddate = FOREACH readinput GENERATE FLATTEN(STRSPLIT(year,'_')) AS (dat:chararray,artxt:chararray),textval;

-- Seperate date and sentiment values from other fields
weights = FOREACH finddate GENERATE dat, textval;

-- Group all sentiment values based on date
groupbydate = GROUP weights BY dat;

-- Find average values for a particular date
avrg = FOREACH groupbydate{ temp = weights.dat; dis = DISTINCT temp; GENERATE dis.dat, AVG(weights.textval);};

-- Store the output in a seperate file
STORE avrg INTO '/user/cloudera/amznavg' USING PigStorage(',');



