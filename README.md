# BDAL_Project 
Big Data Analytics Final Project  
Twitter Sentiment Analysis using Hadoop HDFS, MapReduce and Apache Pig  

This project demonstrates a complete Big Data Analytics workflow using Hadoop HDFS, Java MapReduce, and Apache Pig to process and analyze the Kaggle Twitter Sentiment dataset. The analysis includes sentiment classification, user-level tweet sorting, and dataset joins, with results compared between MapReduce and Pig implementations.

1. Project Objectives
- Store the Kaggle Twitter dataset in Hadoop Distributed File System (HDFS).  
- Demonstrate distributed storage and block management.  
- Process the dataset using Java MapReduce.  
- Perform equivalent sentiment analysis using Apache Pig.  
- Compare MapReduce and Pig results.  
- Present clear analytical outputs (sentiment counts, sorted tweets, joined data).  

2. Dataset
Dataset: [Twitter Sentiment Analysis - Kaggle](https://www.kaggle.com/datasets/raj713335/twittesentimentanalysis)  

Size: ~1.6M tweets  
Labels:  
0 → Negative sentiment  
4 → Positive sentiment  
Attributes: target (sentiment label), ids (tweet ID), date (timestamp), flag (query flag), user (username), text (tweet content)  

3. HDFS Implementation
hdfs dfs -mkdir /twitter  
hdfs dfs -put tweets.csv /twitter/  
hdfs dfs -ls /twitter  

4. MapReduce Analysis
Implemented Java MapReduce program:  
SentimentCount.java → counts positive vs negative tweets  

Run example:  
hadoop jar SentimentCount.jar SentimentCount /twitter/tweets.csv /pig_output/sentiment_counts  

Outputs: Positive tweets count, Negative tweets count  

5. Apache Pig Analysis
Pig script: twitter_analysis.pig  

Tasks performed:  
- Load dataset  
- Clean sentiment labels  
- Filter positive tweets  
- Project user + text  
- Sort tweets by user  
- Group by sentiment → counts  
- Join datasets  

Outputs stored in HDFS:  
/pig_output/sentiment_counts  
/pig_output/sorted_tweets  
/pig_output/joined_data  

6. Results & Key Findings
- Sentiment Counts → distribution of positive vs negative tweets  
- Sorted Tweets → tweets ordered by user  
- Joined Data → combined dataset for deeper analysis  

7. Project Structure
BDAL_Final_Project/  
hdfs/commands.txt  
mapreduce/SentimentCount.java, SentimentCount.class, SentimentCount.jar  
pig/twitter_analysis.pig  
screenshots/hdfs, mapreduce, pig  
tweets.csv (optional, large dataset not pushed)  
.gitignore  
README.md  

8. How to Run
1. Start Hadoop (HDFS + YARN)  
2. Verify with jps  
3. Upload dataset:  
   hdfs dfs -mkdir /twitter  
   hdfs dfs -put tweets.csv /twitter/  
4. Run MapReduce:  
   hadoop jar SentimentCount.jar SentimentCount /twitter/tweets.csv /pig_output/sentiment_counts  
5. Run Pig:  
   pig twitter_analysis.pig  

9. Limitations
- Dataset is large, not stored in repo  
- Local pseudo-distributed Hadoop setup  
- Analysis limited to binary sentiment classification  

10. Future Improvements
- Add word frequency analysis  
- Add visualization of sentiment distribution  
- Extend to multi-class sentiment (positive, negative, neutral)  
- Use Hive/Spark for advanced queries  
- Build dashboard for interactive analysis  

11. Conclusion
This project demonstrates a complete Big Data workflow using HDFS, Java MapReduce, and Apache Pig. The Kaggle Twitter dataset was successfully stored and processed, and equivalent analytical results were obtained using both MapReduce and Pig.  

Findings:  
- Positive vs negative sentiment distribution  
- User-level tweet sorting  
- Joined dataset for deeper analysis  

Repository  
GitHub: sabihajannat1134/BDAL_Final_Project  
Dataset Reference: Twitter Sentiment Analysis - Kaggle  

