//
//  KobusWeb.h
//  KobusReservation
//
//  Created by kim hongjun on 11. 9. 30..
//  Copyright 2011년 앱달. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KobusReservationObject.h"
#import "KobusReservationInfoList.h"
typedef void (^infoList)(KobusReservationInfoList*);


@interface KobusWeb : NSObject 

@property (nonatomic,retain) NSString *responseString;
@property (nonatomic,retain) MutableSortedDictionary *Origins;
@property (nonatomic,retain) MutableSortedDictionary *Destinations;

- (void)loadKoBusWeb;
- (void)processRouteData;
- (void)processReservationInfo;
- (void)sendReservationInfoUsingPostMethod:(KobusReservationObject*)resvObj;
- (KobusReservationInfoList*)processReservationInfoList:(NSData*)responseData;
- (void)sendReservationInfoQueryString:(NSString*)params withInfoList:(infoList)infolist;
@end
