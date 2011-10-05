#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif


/**
 Extends the NSString class to simplify the indentation of strings written to some output.
 */
@interface NSString (Indent)

+ (NSString *) stringWith: (NSInteger) count copiesOfString: (NSString *) copyMe;

@end
