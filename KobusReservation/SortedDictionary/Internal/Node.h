#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif
#import "SortedDictionaryEntry.h"


typedef enum { odLeft = 0, odRight = 1 } ODSide;


@interface Node : NSObject <NSCoding, NSCopying, SortedDictionaryEntry> {
		id		key;
		id		value;
		int		balance;
		Node	*parent;
		Node	*children[2];
	}

	@property (copy, nonatomic)		id		key;
	@property (retain, nonatomic)	id		value;
	@property (assign, nonatomic)	int		balance;
	@property (assign, nonatomic)	Node	*parent;
	@property (assign, nonatomic)	Node	*left;
	@property (assign, nonatomic)	Node	*right;

	- (id) initWithKey: (id) aKey value: (id) aValue andParent: (Node *) aParent;
	- (void) copyContentFromNode: (Node *) aNode;

	- (Node *) childAtSide: (ODSide) aSide;
	- (void) setChild: (Node *) aNode atSide: (ODSide) aSide;

	- (Node *) liveChild;
	- (ODSide) sideOfChild: (Node *) aNode;

	- (int) height;
	- (int) count;

	- (NSString *) description;
	- (NSString *) descriptionWithChildrenAndIndent: (NSInteger) indent;

	// NSCoding
	- (void) encodeWithCoder: (NSCoder *) encoder;
	- (id) initWithCoder: (NSCoder *) decoder;

	// NSCopying
	- (id) copyWithZone: (NSZone *) zone;

@end
