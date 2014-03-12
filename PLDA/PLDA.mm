//
//  PLDA.m
//  PLDA
//
//  Created by Ben Blackburne on 06/03/2014.
//  Copyright (c) 2014 Ben Blackburne. All rights reserved.
//

#import "PLDA.h"
#include <string>
#import "lda.h"
#import "infer.h"
@interface PLDA()
@property (nonatomic) std::vector<string> *corpus;
@property (nonatomic) NSMutableArray *tags;
@property (nonatomic) dispatch_queue_t queue;
@end
@implementation PLDA


- (void)addToCorpus:(LDABagOfWords *)bag withTag:(NSString *)tag
{
	std::string *myString = new std::string;
	[bag.wordCounts enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		myString->append([key UTF8String]);
		myString->append(" ");
		myString->append([[obj description] UTF8String]);
		myString->append(" ");
	}];
	
	dispatch_sync(self.queue, ^{
		self.corpus->push_back(*myString);
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
}

- (id)init
{
    if (self = [super init])
    {
		self.corpus = new std::vector<string>;
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
	return 50.0 / self.corpus->size();
}

- (void)learn
{

    std::map<string, int> wordIndexMap;
    using learning_lda::LDAAccumulativeModel;
    
    
    std::string path([[self.modelFile path] UTF8String]);
    
    learning_lda::LearnFromCorpus(self.corpus,self.numTopics, &wordIndexMap, self.iterations, self.burnin, self.alpha, self.beta, path);
    
}

- (NSArray *)categoryProbs
{
    std::string path([[self.modelFile path] UTF8String]);
    std::vector<std::vector<double>> ans(self.corpus->size());
    infer(path, *(self.corpus), self.alpha, self.beta, self.iterations, self.burnin, ans);
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


@end
