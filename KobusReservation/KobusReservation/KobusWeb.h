//
//  KobusWeb.h
//  KobusReservation
//
//  Created by kim hongjun on 11. 9. 30..
//  Copyright 2011년 앱달. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void (^datas)(SortedDictionary*,SortedDictionary*);


@interface KobusWeb : NSObject 

@property (nonatomic,retain) NSString *responseString;
@property (nonatomic,retain) MutableSortedDictionary *Origins;
@property (nonatomic,retain) MutableSortedDictionary *Destinations;

- (void)loadKoBusWeb;
- (void)processRouteData;

- (void)sendReservationInfoQueryString:(NSString*)params;
- (void)processReservationInfo;
@end
