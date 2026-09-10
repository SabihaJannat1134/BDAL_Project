-- Load tweets dataset (6 columns)
tweets = LOAD '/twitter/tweets.csv'
        USING PigStorage(',')
        AS (target:chararray, ids:chararray, date:chararray, flag:chararray, user:chararray, text:chararray);

-- Clean target column (remove quotes)
cleaned = FOREACH tweets GENERATE
    REPLACE(target, '"', '') AS target,
    user,
    text;

-- FILTER: Only positive tweets
positive_tweets = FILTER cleaned BY target == '4';

-- PROJECT: Select only user and tweet text
projected_tweets = FOREACH positive_tweets GENERATE user, text;

-- SORT: Order tweets by user name
sorted_tweets = ORDER projected_tweets BY user ASC;

-- GROUP: Group tweets by sentiment label
grouped_tweets = GROUP cleaned BY target;
counts = FOREACH grouped_tweets GENERATE group AS sentiment, COUNT(cleaned) AS total;

-- JOIN: Example join (tweets joined with themselves on user)
joined_data = JOIN cleaned BY user, projected_tweets BY user;

-- STORE results in HDFS
STORE sorted_tweets INTO '/pig_output/sorted_tweets' USING PigStorage(',');
STORE counts INTO '/pig_output/sentiment_counts' USING PigStorage(',');
STORE joined_data INTO '/pig_output/joined_data' USING PigStorage(',');
