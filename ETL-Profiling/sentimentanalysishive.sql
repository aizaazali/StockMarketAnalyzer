-- Symbol " -- " implies this line is a comment.

--This script performs sentiment analysis on input data
--create a table for importing text files containing articles
-- We have already loaded the input on hdfs

CREATE TABLE inputdataamzn(
content string)
location '/user/cloudera/amzn/';

-- create another table to store the data by filename as ID

CREATE TABLE amzn(
filename string,
content string);

--insert into the table. This create a table with 2 columns
--column 1 contains filename and columns 2 contains the text of the column

INSERT INTO TABLE amzn SELECT split(INPUT__FILE__NAME,'amzn/')[1],* FROM inputdataamzn;

--Tokenize the sentences of the text.
create table split_words_amzn as select filename as filename,split(content,' ') as words from amzn;

--Flatten the tokenized words, using explode() UDF, to that each word can be analyzed
create table text_word_amzn as select filename as filename, word from split_words_amzn LATERAL VIEW explode(words) w as word;

--Create a table dictionary, in which we will load our wordlist
--This word list is custom created, containing over 6000 word, each with positive or negative sentiment

create table dictionary_eco(word string, rating int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

--load the wordlists into dictionary table
LOAD DATA INPATH '/user/cloudera/newlist.txt' into TABLE dictionary_eco;

--perform join
create table word_join_amzn as select text_word_amzn.filename,text_word_amzn.word,dictionary_eco.rating from text_word_amzn LEFT OUTER JOIN dictionary_eco ON(text_word_amzn.word = dictionary_eco.word);

--average the tokenzied words with rating and group by file name. This each file contains filename and sentiment analysis of the articles in it

select filename,AVG(rating) as rating from word_join_amzn GROUP BY word_join_amzn.filename order by rating DESC;





