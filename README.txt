CONTENTS OF THIS FILE
----------------------
 * Introduction
 * Requirements
 * Installation
 * Files
 * Order and commands to run

Introduction
------------

Stock Market Analyzer extracts news articels from Yahoo! Finance and perfroms sentiment
analysis using Apache Hive and Apache Pig


Requirements
------------

 * Python 2.7 : To extract news headlines and Articles
 * newspaper  : Python library to download news articles
 * beautifulsoup : Python library to scrap webpages
 * Hive and Pig : The project was run in Cloudera Quickstart VM which ships with Hive and Pig installed
 * R           : To graphically respresent data analyzed by Hive and Pig

Installation
------------

 * Install libraries mentioned in Requirements from pypi or pip, and place the project files in working directory.

Files
-----

 * get_headlines.py : scraps headlines(URLs) from Yahoo! finance and stores them in local machine.
 * get_articles.py  : scraps articles from list of URLs downloaded by get_headlines.py
 * sentimentanalysishive.sql : performs sentiment analysis for each article in hive( Assumes data is present in HDFS )
 * analysis.pig : Takes output of sentimentanalysishive.sql and calculates sentiment score for a given day
 * draw_charts.R : Takes output of analysis.pig and stock price data, perfroms normalization and plots them.

Order and commands to run
-------------------------

 1) get_headlines.py ->  This is the first file that is run. It asks user for Company name (Stock ticker) and extracts news headlines & urls
     
       $ python get_headlines.py 
       Output format : links*day*.txt

 2) get_articles.py  -> Run after get_headlines.py. It reads links*day*.txt files stored in local storages and extracts articles for each of them

      $ python get_articles.py
      Output format :  YYYYMMDD_Articlenumber.txt  [ example 20160201_01.txt]

 3) Load data files onto HDFS:     $ hdfs dfs -put data
                                   $ hdfs dfs -put dictionary

 4) sentimentanalysishive.sql -> This is the third file to be run in order. It takes stock data and perfoms sentiment analysis using our dictionary.

        $ hive -f sentimentanalysishive.sql
        Output format: Outputs a CSV file with following format:   *Filename*,*SentimentScore*

 5) analysis.pig  -> This is the fourth file to be run. It calculates sentiment scores for individual days
     
        $ pig analysis.pig

    NOTE: EDIT the path of your files in sentimentanalysishive.sql and analysis.pig. They have been hardcoded.

 6) draw_charts.R  -> This is the last file to be run. It normalizes the data and plots them

        We have used RStudio to create and run R files.
        A source file can also be executed like this ->  r -f draw_charts.R