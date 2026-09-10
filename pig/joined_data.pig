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

-- JOIN: Example join (tweets joined with themselves on user)
joined_data = JOIN cleaned BY user, projected_tweets BY user;

-- STORE results in HDFS
STORE joined_data INTO '/pig_output/joined_data' USING PigStorage(',');
