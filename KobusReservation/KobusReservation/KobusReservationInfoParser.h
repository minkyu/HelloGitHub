//
//  KobusReservationInfoParser.h
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 24..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KobusReservationInfoList.h"

@interface KobusReservationInfoParser : NSObject
+ (KobusReservationInfoList*)parsing:(NSData*)responseData;
@end
