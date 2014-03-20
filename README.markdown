This is a wrapper around the [PLDA](https://code.google.com/p/plda/) Latent Dirichlet Allocation toolkit. It is currently a work-in-progress.

Example usage:

```
BPBLDAModel *plda = [[BPBLDAModel alloc] init];

//foreach document with *uuid and *paragraph
{
  BPBBagOfWords *bow = [[BPBBagOfWords alloc] init];
  for(NSString *paragraph in paragraphs){
    //this stems and removes stop words, so don't
    //worry about that
    [bow addText:str];
  }
  //we can do this part multithreaded, as this method should be reentrant:
  [plda addBagToCorpus:bow withTag:uuid inferenceOnly:NO];
}

//Learn from the model:

plda.numTopics=6;
plda.burnin=110;
plda.iterations=150;
//this is slow, don't do it on the main thread:
[plda learn]; 


//Infer topics

plda.burnin=30;
plda.iterations=60;
NSArray *uuids = [plda corpusTags];
//this is slow, don't do it on the main thread
NSArray *topics = [plda topicProbs]; 

/*
Topics contains one array for each document.
Each array contains plda.numTopics double values.
Each value is the expected number of words generated
by each topic. The total of these values should be 
equal to the number of words in each document (minus the 
stop words).
*/

//Get the most informative five (stemmed) words for topic i:

[plda toptags:5 forTopic:i];

```
