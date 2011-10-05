#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif
#import "SortedDictionaryEntry.h"


@class Node;


@interface EntryEnumerator : NSEnumerator {
		Node	*node;
		SEL		first;
		SEL		second;
	}

	- (NSArray *) allObjects;
	- (id) nextObject;

@end
