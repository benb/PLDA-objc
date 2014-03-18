//
//  LDABagOfWords.h
//  PLDA
//
//  Created by Ben Blackburne on 10/03/2014.
//  Copyright (c) 2014 Ben Blackburne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPBBagOfWords : NSObject

@property (nonatomic) NSMutableDictionary* wordCounts;
- (void)addWord:(NSString *)word;
- (void)addText:(NSString *)text;
+ (NSString *)unstem:(NSString *)stemmedWord fromSampleText:(NSArray *)texts;

@end
