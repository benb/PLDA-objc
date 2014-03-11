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

@implementation PLDA

- (id)init
{
    if (self = [super init])
    {
        self.alpha = 0.5;
        self.beta = 0.5;
        self.numTopics=10;
        self.iterations=100;
        self.burnin=20;
        NSString *str = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.modelFile = [NSURL fileURLWithPath:[str stringByAppendingPathComponent:@"/lda.model"]];
    }
    return self;
}

- (void) convertBagOfWords:(NSArray *)bagOfWords target:(std::vector<string>&)myBag
{
    std::map<string, int> wordIndexMap;
    
    for (NSDictionary *line in bagOfWords)
    {
		NSMutableString *lineAsString = [[NSMutableString alloc] init];
		[line enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
			if ([key hasContent])
			{
				[lineAsString appendString:key];
				[lineAsString appendString:@" "];
				[lineAsString appendString:[obj description]];
				[lineAsString appendString:@" "];
			}
		}];
        myBag.push_back(*new std::string([lineAsString UTF8String]));
    }

}

- (void)learnFromDocuments:(NSArray *)bagsOfWords
{

    std::vector<string> myBag;
    [self convertBagOfWords:bagsOfWords target:myBag];
    std::map<string, int> wordIndexMap;
    using learning_lda::LDAAccumulativeModel;
    
    
    std::string path([[self.modelFile path] UTF8String]);
    
    learning_lda::LearnFromCorpus(&myBag,self.numTopics, &wordIndexMap, self.iterations, self.burnin, self.alpha, self.beta, path);
    
}

- (NSArray *)categoryProbForDocuments:(NSArray *)bagsOfWords
{
    std::vector<string> myBag;
    [self convertBagOfWords:bagsOfWords target:myBag];
    std::string path([[self.modelFile path] UTF8String]);
    std::vector<std::vector<double>> ans([bagsOfWords count]);
    infer(path, myBag, self.alpha, self.beta, self.iterations, self.burnin, ans);
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
