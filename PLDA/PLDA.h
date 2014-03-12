//
//  PLDA.h
//  PLDA
//
//  Created by Ben Blackburne on 06/03/2014.
//  Copyright (c) 2014 Ben Blackburne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDABagOfWords.h"

@interface PLDA : NSObject

@property (nonatomic) int numTopics;
@property (nonatomic, readonly) double alpha;
@property (nonatomic) double beta;
@property (nonatomic) int iterations;
@property (nonatomic) int burnin;
@property (nonatomic) NSURL *modelFile;
- (void)addToCorpus:(LDABagOfWords *)bag withTag:(NSString *)tag;
- (NSArray *)corpusTags;
- (void)learn;
- (NSArray *)categoryProbs;
@end
