//
//  KobusReservationObject.h
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 12..
//  Copyright 2011년 앱달. All rights reserved.
//



@interface KobusReservationObject : NSObject

@property (nonatomic,copy) NSString *origin; // 출발지
@property (nonatomic,copy) NSString *destination; // 도작치
@property (nonatomic,copy) NSString *date; //출발일
@property (nonatomic,copy) NSString *busClass; // 버스등급
@property (nonatomic,copy) NSString *ticketCount; // 매수

- (BOOL)shuldReservateOnEasyInternet;
- (BOOL)requestedNoTicket;
- (BOOL)requestedExcessTicket;

@end
