#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif


/**
 Extends the NSString class to support Base64 encoding and decoding.
 */
@interface NSString (Base64)

	- (NSData *) decodeBase64;
	+ (id) encodeBase64: (NSData *) data;

@end
