import java.io.IOException;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class SentimentCount {

    // Mapper: reads each line (tweet record)
    public static class SentimentMapper extends Mapper<LongWritable, Text, Text, IntWritable> {
        private final static IntWritable one = new IntWritable(1);
        private Text sentiment = new Text();

        public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
            // Split into 6 fields: target, ids, date, flag, user, text
            String[] fields = value.toString().split(",", 6); 
            if (fields.length > 0) {
                // Remove quotes and trim spaces
                String target = fields[0].replaceAll("\"", "").trim();

                if (target.equals("0")) {
                    sentiment.set("Negative");
                } else if (target.equals("4")) {
                    sentiment.set("Positive");
                } else {
                    sentiment.set("Unknown");
                }
                context.write(sentiment, one);
            }
        }
    }

    // Reducer: sums counts for each sentiment
    public static class SentimentReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
        public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
            int sum = 0;
            for (IntWritable val : values) {
                sum += val.get();
            }
            context.write(key, new IntWritable(sum));
        }
    }

    // Driver: configures and runs the job
    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "Sentiment Count");
        job.setJarByClass(SentimentCount.class);
        job.setMapperClass(SentimentMapper.class);
        job.setCombinerClass(SentimentReducer.class);
        job.setReducerClass(SentimentReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}
