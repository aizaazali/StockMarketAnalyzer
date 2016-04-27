-- For every stock there are a number of news articles every day - some negative and some positive. 
-- Once the sentiment values are obtained for news articles, a Pig script will help us to calculate the average sentiment of an organization for the day.
-- The inputs.txt is of the format "date_articlenumber headlinesentimentvalue articlesentimentvalue".
-- For example "20151201_1 2.954 3.231" and "20151201_2 -2.432 -0.932"can be the inputs.
-- The output will be in the format "date averagesetiment"

-- READ THE INPUT
readinput = LOAD '/user/cloudera/inputs/inputs.txt' using PigStorage(' ') AS (year:chararray, headval:double, textval:double);

-- Assigning 30% weightage to headlines and 70% to the article text 
calweight = FOREACH readinput GENERATE *, (headval*0.3) as headline, (textval*0.7) as text;

-- Calculate overall sentiment for a particular article
totalweight = FOREACH calweight GENERATE *, (headline+text) as weight;

-- Split date_articlenumber to get the date and we can group it later.
finddate = FOREACH totalweight GENERATE FLATTEN(STRSPLIT(year,'_')) AS (dat:chararray,article:chararray), headval, textval, headline, text, weight;

-- Consider only date and sentiment value of article
weights = FOREACH finddate GENERATE dat, (double)weight as sum;

--  Group by Date
groupbydate = GROUP weights BY dat;

-- Calculate average sentiment for a particular date
avrg = FOREACH groupbydate{ temp = weights.dat; dis = DISTINCT temp; GENERATE dis.dat, AVG(weights.sum);};

-- Observe the output
dump avrg;
