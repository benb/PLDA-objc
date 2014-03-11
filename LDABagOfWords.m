//
//  LDABagOfWords.m
//  PLDA
//
//  Created by Ben Blackburne on 10/03/2014.
//  Copyright (c) 2014 Ben Blackburne. All rights reserved.
//

#import "LDABagOfWords.h"

@interface LDABagOfWords()
@property (nonatomic) NSMutableDictionary* wordCounts;
@end
@implementation LDABagOfWords

- (void)addWord:(NSString *)word
{
    if (self.wordCounts[word])
    {
        self.wordCounts[word] = [NSNumber numberWithInt:[self.wordCounts[word] intValue] +1];
    }
    else
    {
        self.wordCounts[word] = [NSNumber numberWithInt:1];
    }
}

- (NSMutableDictionary *)wordCounts
{
    if (!_wordCounts)
    {
        _wordCounts=[NSMutableDictionary dictionaryWithCapacity:500];
    }
    return _wordCounts;
}

- (NSDictionary *)bag
{
    return [self.wordCounts copy];
}

@end
