#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif
#import "SortedDictionary.h"


@interface SortedDictionary (Private)

	- initWithTree: (AvlTree *) newTree;
	- (void) addEntriesFromDictionary: (NSDictionary *) otherDictionary copyItems: (BOOL) flag;
	- (void) addEntriesFromSortedDictionary: (SortedDictionary *) otherDictionary copyItems: (BOOL) flag;

@end
