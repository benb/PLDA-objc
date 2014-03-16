//
//  LDABagOfWords.m
//  PLDA
//
//  Created by Ben Blackburne on 10/03/2014.
//  Copyright (c) 2014 Ben Blackburne. All rights reserved.
//

#import "LDABagOfWords.h"
#import "PorterStemmer.h"

@interface LDABagOfWords()

@end
@implementation LDABagOfWords

/**
 The distribution comes with a set of stop words that are global across all models.
 You should change this if your documents' language isn't English.
 */
+ (NSSet *)stopWords
{
    static dispatch_once_t once;
	static NSSet *set;
	dispatch_once(&once, ^{
		set = [NSSet setWithArray:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"stopwords" ofType:@"plist" ]]];
	});
	return set;
}

/**
 Add a single word to the bag. You should probably use a stemmer.
 */
- (void)addWord:(NSString *)word
{
	if ([[self.class stopWords] containsObject:word] || [word length] < 3)
	{
		return;
	}
    if (self.wordCounts[word])
    {
        self.wordCounts[word] = [NSNumber numberWithInt:[self.wordCounts[word] intValue] +1];
    }
    else
    {
        self.wordCounts[word] = [NSNumber numberWithInt:1];
    }
}


/**
 Add a chunk of text in a string to the bag. This method will loop over the words in the string and
 use the Porter stemmer algorithm on the words before adding them.
 */
- (void)addText:(NSString *)text
{
	NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:@[NSLinguisticTagSchemeTokenType] options:0];
	[tagger setString:text];
	[tagger enumerateTagsInRange:NSMakeRange(0,[text length]) scheme:NSLinguisticTagSchemeTokenType options:(NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerOmitOther) usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
		if (tag)
		{
			NSString *word = [[text substringWithRange:tokenRange] lowercaseString];
			if (![[self.class stopWords] containsObject:word] && [word rangeOfCharacterFromSet:[[NSCharacterSet lowercaseLetterCharacterSet] invertedSet]].location == NSNotFound){
				NSString *stem = [word stem];
				if (stem)
					[self addWord:stem];
			}
		}
	}];
}

/**
 This will take a given word and attempt to unstem it given a representitive array of NSStrings.
 i.e. Given "struct" it will find words that stem to "struct" in the text and return the first one
 to occur five times, else the most frequent. If the text does not have any words that stem to `stemmedWord` then this will return nil.
 */
+ (NSString *)unstem:(NSString *)stemmedWord fromSampleText:(NSArray *)texts
{
	NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:@[NSLinguisticTagSchemeTokenType] options:0];
	NSMutableDictionary *words = [NSMutableDictionary dictionary];
	__block NSString *bestWord;
	for (NSString *text in texts)
	{
		
	[tagger setString:text];
		[tagger enumerateTagsInRange:NSMakeRange(0,[text length]) scheme:NSLinguisticTagSchemeTokenType options:(NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerOmitOther) usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
			if (tag && !*stop)
			{
				NSString *word = [[text substringWithRange:tokenRange] lowercaseString];
				NSString *stem = [word stem];
				if (stem && [stem isEqualToString:stemmedWord])
				{
					if (words[word])
					{
						words[word] = [NSNumber numberWithInt:[words[word] intValue]+1];
						if ([words[word] intValue] >  5)
						{
							bestWord=word;
							*stop=YES;
						}
					}
					else
					{
						words[word]=[NSNumber numberWithInt:1];
					}
				}
			}
		}];
		if (bestWord)
			return bestWord;
	}
	int bestInt=0;
	[words enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		if ([obj intValue] > bestInt)
		{
			bestWord = key;
		}
	}];
	return bestWord;
}

- (NSMutableDictionary *)wordCounts
{
    if (!_wordCounts)
    {
        _wordCounts=[NSMutableDictionary dictionaryWithCapacity:500];
    }
    return _wordCounts;
}

@end
