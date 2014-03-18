//
//  BPBLDAModel.m
//  PLDA
//
//  Created by Ben Blackburne on 06/03/2014.
//  Copyright (c) 2014 Ben Blackburne. All rights reserved.
//

#import "BPBLDAModel.h"
#include <string>
#import "lda.h"
#import "infer.h"
#include "stdio.h"

@interface BPBLDAModel()
@property (nonatomic) std::vector<string> *corpus;
@property (nonatomic) std::vector<string> *inference;
@property (nonatomic) NSMutableArray *tags;
@property (nonatomic) dispatch_queue_t queue;
@end
@implementation BPBLDAModel

/**
 Add an LDABagOfWords to the corpus. If inferenceOnly is YES this bag of words will not be used for
 training but only for inference.
 Each bag of words can have a tag associated with it so we know what it is (e.g. some kind of ID or a DOI).
 */

- (void)addBagToCorpus:(BPBBagOfWords *)bag withTag:(NSString *)tag inferenceOnly:(BOOL)inferenceOnly
{
	
	std::string *myString = new std::string;
	[bag.wordCounts enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		myString->append([key UTF8String]);
		myString->append(" ");
		myString->append([[obj description] UTF8String]);
		myString->append(" ");
		
	}];
	
	dispatch_sync(self.queue, ^{
		if (!inferenceOnly)
		{
			self.corpus->push_back(*myString);
		}
		self.inference->push_back(*myString);
		if (tag)
			[self.tags addObject:tag];
		else
			[self.tags addObject:[NSNull null]];
	});
	delete myString;
}

- (NSArray *)corpusTags
{
	return [self.tags copy];
}

- (void)dealloc
{
	delete self.corpus;
	delete self.inference;
}

- (id)init
{
    if (self = [super init])
    {
		self.corpus = new std::vector<string>;
		self.inference= new std::vector<string>;
		self.tags = [NSMutableArray array];
        self.beta = 0.5;
        self.numTopics=10;
        self.iterations=100;
        self.burnin=20;
		self.queue = dispatch_queue_create("com.mekentosj.plda", NULL);
        NSString *str = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.modelFile = [NSURL fileURLWithPath:[str stringByAppendingPathComponent:@"/lda.model"]];
    }
    return self;
}

- (double)alpha
{
	return 50.0 / self.numTopics;
}

/**
 Perform `iterations` iterations and save the model to the path `modelFile`.
 */
- (void)learn
{

	if ([[NSFileManager defaultManager] fileExistsAtPath:[self.modelFile path]])
	{
		return;
	}
	
    std::map<string, int> wordIndexMap;
    using learning_lda::LDAAccumulativeModel;
    
    
    std::string path([[self.modelFile path] UTF8String]);
    
    learning_lda::LearnFromCorpus(self.corpus,self.numTopics, &wordIndexMap, self.iterations, self.burnin, self.alpha, self.beta, path);
    
}

/**
 Perform inference and return an NSArray, where each entry is an NSArray containing a single NSNumber for each topic, which is the expected number of words generated by that topic.
 */
- (NSArray *)topicProbs
{
    std::string path([[self.modelFile path] UTF8String]);
    std::vector<std::vector<double> > ans(self.inference->size());
    infer(path, *(self.inference), self.alpha, self.beta, self.iterations, self.burnin, ans);
    NSMutableArray *probs = [NSMutableArray arrayWithCapacity:ans.size()];
    for (int i=0; i < ans.size(); i++)
    {
        vector<double> vect = ans[i];
        [probs addObject:[NSMutableArray arrayWithCapacity:ans[i].size()]];
        for (vector<double>::iterator iter = vect.begin(); iter != vect.end(); ++iter)
        {
            double x = *iter;
            [probs[i] addObject:[NSNumber numberWithDouble:x]];
        }
    }
    return probs;
}

/**
 Using the generated model, return the top `numTags` words for topic `topic`. These are expected 
 to be related to the underlying topic; a topic about evolution may have the words "evolution", "selection", "mutation", "gene", "chromosome", etc.
 Note that if you used a stemmer then you will get stemmed words back.
 */
- (NSArray *)toptags:(NSInteger)numTags forTopic:(NSInteger)topic
{
	if (![[NSFileManager defaultManager] fileExistsAtPath:[self.modelFile path]])
		return nil;
	FILE *f = fopen([self.modelFile fileSystemRepresentation],"r");
	char line[LINE_MAX];
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:numTags];
	
	while (fgets(line, LINE_MAX, f) != NULL) {
		NSString *nsline = [NSString stringWithCString:line encoding:NSUTF8StringEncoding];
		NSMutableArray *components = [[nsline componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
		[components removeObject:@""];
		[components removeObject:[NSNull null]];
		double weight = [components[topic+1] doubleValue];
		if ([result count] < numTags)
		{
			[result addObject:@[components[0],[NSNumber numberWithDouble:weight]]];
			[result sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
				return [obj1[1] compare:obj2[1]];
			}];
		}
		else if ([result[0][1] doubleValue] < weight)
		{
			result[0]=@[components[0],[NSNumber numberWithDouble:weight]];
			[result sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
				return [obj1[1] compare:obj2[1]];
			}];
		}
	}
	NSMutableArray *words = [NSMutableArray arrayWithCapacity:numTags];
	[result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		words[idx]=result[idx][0];
	} ];
	return words;
}


@end