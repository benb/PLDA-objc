//
//  PLDA.h
//  PLDA
//
//  Created by Ben Blackburne on 06/03/2014.
//  Copyright (c) 2014 Ben Blackburne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLDA : NSObject

@property (nonatomic) int numTopics;
@property (nonatomic) double alpha;
@property (nonatomic) double beta;
@property (nonatomic) int iterations;
@property (nonatomic) int burnin;
@property (nonatomic) NSURL *modelFile;
- (void)learnFromDocuments:(NSArray *)bagsOfWords;
- (NSArray *)categoryProbForDocuments:(NSArray *)bagsOfWords;
@end
