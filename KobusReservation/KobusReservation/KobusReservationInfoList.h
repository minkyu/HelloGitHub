//
//  KobusReservationInfoList.h
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 23..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KobusReservationInfoList : NSObject

@property (nonatomic,retain) NSMutableArray *infoList;
@property (nonatomic,retain) NSMutableArray *hideInfoList;

- (void)addInfoList:(NSArray*)str;
- (void)addHideInfoList:(NSDictionary *)objects;
- (int)getBusClass:(NSInteger)index;
- (NSString*)getTypeStringAtIndex:(NSInteger)index;
@end
