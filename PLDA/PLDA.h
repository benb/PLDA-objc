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

/**
 The number of topics to infer
 */
@property (nonatomic) int numTopics;
/**
 alpha is a parameter for the LDA process. It is recommended to be 50/numTopics, and this is enforced
 */
@property (nonatomic, readonly) double alpha;

/**
 beta is a parameter for the LDA process, it is recommended to be 0.01, which this defaults to.
 */
@property (nonatomic) double beta;

/**
 Number of iterations (including burn-in) to perform. You probably want to reduce this for the inference stage.
 The PLDA people claim tens of iterations is enough for inference, more than this for the learning stage.
 */
@property (nonatomic) int iterations;
/**
 The number of iterations to discard. If you don't know what this is, set this to something like iterations-30.
 */
@property (nonatomic) int burnin;

/**
 Path to save/load the model file.
 */
@property (nonatomic) NSURL *modelFile;


- (void)addBagToCorpus:(LDABagOfWords *)bag withTag:(NSString *)tag inferenceOnly:(BOOL)inferenceOnly;
- (NSArray *)corpusTags;
- (void)learn;
- (NSArray *)categoryProbs;
- (NSArray *)toptags:(NSInteger)numTags forCategory:(NSInteger)category;
@end
