//
//  KobusWeb.h
//  KobusReservation
//
//  Created by kim hongjun on 11. 9. 30..
//  Copyright 2011년 앱달. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KobusWeb : NSObject 
{
	NSMutableData *responseData;
}

- (void)loadOrigin;
- (void)loadDestination;

@end
