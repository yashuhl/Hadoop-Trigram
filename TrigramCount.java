/* Written by Yashaswini */

package TrigramCount;

import java.io.IOException;
import java.util.Iterator;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class TrigramCount
{

/* Mapper class with 4 attributes*/
public static class TrigramMapper extends 
Mapper<Object, 
       Text,
       Text,
       IntWritable>
{  
	/* Initializing TRIGRAM as static for avoiding mutability*/
    private static final Text TRIGRAMMAPPER = new Text();
    
    /* Mapper function */
    public void map(Object key, 
    		        Text value,
    		        Context context) throws IOException, InterruptedException
    
     {
    	/* reading text file which will be given for mapper line by line*/
		String textLine=value.toString();
		String First = null;
		String Second = null;
      
		/* Splitting the text file on the basis of delimiter space(" ") */
		for(String wordTaken:textLine.split(" "))
		{	
			/* Taking the third word every time */
			String Third = wordTaken;
			if (First != null && Second != null) 
	        {
				TRIGRAMMAPPER.set(First + " " + Second + " " + Third);
	            context.write(TRIGRAMMAPPER, new IntWritable(1));
	        }
			/* pushing second word to first and third word to second */
			First = Second;
	        Second = Third;
		}
    }
  }

/* Reducer class with 4 attributes*/
public static class TrigramSumReducer extends
Reducer<Text,
        IntWritable,
        Text,
        IntWritable> 

  {
    private IntWritable TRIGRAMREDUCERSUM = new IntWritable();

    /* Reducer function */
    public void reduce(Text Reducekey,
    		           Iterable<IntWritable> trigramReduceValue,
    		           Context context) throws IOException, InterruptedException
     {
    	int takenTrigramCount = 0;
    	Iterator<IntWritable> trigramReduceIterator = trigramReduceValue.iterator();
    	
		// Till the iterator has next value
		while (trigramReduceIterator.hasNext())
		{
			//increment to next value
			takenTrigramCount+=trigramReduceIterator.next().get();
		}
		/* sending output to given writable file */
        TRIGRAMREDUCERSUM.set(takenTrigramCount);
        context.write(Reducekey, TRIGRAMREDUCERSUM);
    }
  }

public static void main(String[] args) throws Exception 
{
    Configuration conf = new Configuration();
	/* Passing 3 arguments only else error capturing
	 * First Argument Input file
	 * Second Argument Output file
	 * Third Argument number of reducer
	 * */
    if (args.length != 3) 
    {
    	
		System.out.println("please check input file argument"+args[0]+"properly");
		System.out.println("please check output file argument"+args[1]+"properly");
		System.out.println("please check number of reducer"+args[2]+"properly");
		return;
    }
    String trigramInputPath = args[0];
    String trigramOutputPath = args[1];
    int reducers = Integer.parseInt(args[2]);
    
    /* Job instance */
    Job job = Job.getInstance(conf, "Trigram count");
    /* Setting the job */
    job.setJobName(TrigramCount.class.getSimpleName());
    /* placing the jar */
    job.setJarByClass(TrigramCount.class);
    /* calling the number of reducer */
    job.setNumReduceTasks(reducers);
    
    /* Input and output files */
    FileInputFormat.setInputPaths(job, new Path(trigramInputPath));
    FileOutputFormat.setOutputPath(job, new Path(trigramOutputPath));
    
    /* calling Mapper */
    job.setMapperClass(TrigramMapper.class);
    /* calling Reducer */
    job.setReducerClass(TrigramSumReducer.class);
    /* calling output */
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);
    
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}