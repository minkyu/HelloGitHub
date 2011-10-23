//
//  KobusRouteWeb.h
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 17..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KobusRouteParser : NSObject

+ (MutableSortedDictionary *)parseOrigins:(NSString*)aStr;
+ (MutableSortedDictionary *)parseDestinations:(NSString*)aStr;
@end
