//
//  KobusReservationObject.h
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 12..
//  Copyright 2011년 앱달. All rights reserved.
//



@interface KobusReservationQueryData : NSObject

@property (nonatomic,copy) NSString *origin; // 출발지
@property (nonatomic,copy) NSString *destination; // 도작치
@property (nonatomic,copy) NSString *date; //출발일
@property (nonatomic,copy) NSString *busClass; // 버스등급
@property (nonatomic,copy) NSString *ticketCount; // 매수


// 사이트에 사용되는 param
@property (nonatomic, copy) NSString *TER_FR;
@property (nonatomic, copy) NSString *TER_TO;
@property (nonatomic, copy) NSString *Tim_date_Year;
@property (nonatomic, copy) NSString *Tim_date_Month;
@property (nonatomic, copy) NSString *Tim_date_Day;
@property (nonatomic, copy) NSString *TIM_TIM_I;
@property (nonatomic, copy) NSString *BUS_GRA_I;
@property (nonatomic, copy) NSString *pCnt_100;
@property (nonatomic, copy) NSString *pCnt_050;

- (NSString *)checkValidation;
- (BOOL)shuldReservateOnEasyInternet;
- (BOOL)requestedNoTicket;
- (BOOL)requestedExcessTicket;

//- (NSDictionary*)toPostData;
//- (NSArray*)toPostArray;
- (NSString*)toGETParamString;

@end
