-- Load tweets dataset (6 columns)
tweets = LOAD '/twitter/tweets.csv'
        USING PigStorage(',')
        AS (target:chararray, ids:chararray, date:chararray, flag:chararray, user:chararray, text:chararray);

-- Clean target column (remove quotes)
cleaned = FOREACH tweets GENERATE
    REPLACE(target, '"', '') AS target,
    user,
    text;

-- GROUP: Group tweets by sentiment label
grouped_tweets = GROUP cleaned BY target;
counts = FOREACH grouped_tweets GENERATE group AS sentiment, COUNT(cleaned) AS total;

-- STORE results in HDFS
STORE counts INTO '/pig_output/sentiment_counts' USING PigStorage(',');
