//
//  LDABagOfWords.h
//  PLDA
//
//  Created by Ben Blackburne on 10/03/2014.
//  Copyright (c) 2014 Ben Blackburne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDABagOfWords : NSObject

- (NSDictionary *)bag;

- (void)addWord:(NSString *)word;

@end
