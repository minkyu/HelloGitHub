//
//  KobusReservationObject.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 12..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "KobusReservationObject.h"

@implementation KobusReservationObject

@synthesize origin,destination,date,busClass,ticketCount;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSString*)description
{
	NSMutableString	*descriptionStr = [NSMutableString string];
	[descriptionStr appendFormat:@"Origin = %@\n",origin]; // 출발지
	[descriptionStr appendFormat:@"Destination = %@\n",destination];
	[descriptionStr appendFormat:@"Date = %@\n",date];
	[descriptionStr appendFormat:@"BusClass = %@\n",busClass];
	[descriptionStr appendFormat:@"TicketCount = %@\n",ticketCount];
	return descriptionStr;
}

- (NSDictionary*)toPostData
{
	//예약할 좌석 조회 화면 조회 시 아래의 데이터가 POST 방식으로 넘어감
	//TER_FR=115&TER_TO=200&Tim_date_Year=2011&Tim_date_Month=10&Tim_date_Day=15&TIM_TIM_I=1400&BUS_GRA_I=4&pCnt_100=1&pCnt_050=2
	// TODO 아래의 구조에 맞게 저장된 데이터 변환하긔
	NSDictionary *data = [[NSDictionary alloc] init];
	[data setValue:@"" forKey:@"TER_FR"]; // 출발지 코드
	[data setValue:@"" forKey:@"TER_TO"]; // 도착지 코드
	[data setValue:@"" forKey:@"Tim_data_Year"]; // 예약 년도
	[data setValue:@"" forKey:@"Tim_data_Month"]; // 예약 월
	[data setValue:@"" forKey:@"Tim_data_Day"]; // 예약 일
	[data setValue:@"" forKey:@"TIM_TIM_I"]; // 예약 시간
	[data setValue:@"" forKey:@"BUS_GRA_I"]; // 버스 등급
	[data setValue:@"" forKey:@"pCnt_100"]; // 어른 티켓 수
	[data setValue:@"" forKey:@"pCnt_050"]; // 아이 티켓 수
	
	return data;
}

#pragma mark -
#pragma mark Validation

// 예약할 좌석 조회 전 저장된 값의 유효성을 확인
- (NSString *)checkValidation
{
	NSString *returnCode = @"OK";
	
	// TODO 각 항목에 빈 값이 없는지
	// TODO 예약 가능한 시간인지 확인 (현재 시간을 기준으로 한시간 이전에만 가능)
	
	if ([self shuldReservateOnEasyInternet]) return @"EASY_INTERNET";
	if ([self requestedNoTicket]) return @"NO_TICKET";
	if ([self requestedExcessTicket]) return @"EXCESS_TICKET";
	
	
	
	return returnCode;
}

// 아래의 출발지는 코버스에서 예약 불가. 이지 인터넷으로 데이터를 넘겨서 해당 사이트에서 처리하는 대상이다.
// 본 프로그램에선 일단 제외하는 걸로.
- (BOOL)shuldReservateOnEasyInternet
{
	if([destination isEqualToString:@"310"] || [destination isEqualToString:@"020"] 
	   || [destination isEqualToString:@"032"] || [destination isEqualToString:@"190"] || [destination isEqualToString:@"456"])
		return YES;
	return NO;
}

// 티켓 수 확인	
- (BOOL)requestedNoTicket
{
	// TODO 어른티켓 아이티켓 구분하고 그에 맞게 수정하긔
	if ([ticketCount intValue] < 1) return YES;
	return NO;
}

// 티켓이 좌석보다 초과하는지 확인
// 고급 27석 일반 45석
// TODO 어른티켓 아이티켓 분리 시 아래 함수는 합산을 기준으로 변경
- (BOOL)requestedExcessTicket
{

	int maxTicket = 27;
	if ([busClass isEqualToString:@"0"] || [busClass isEqualToString:@"1"] || [busClass isEqualToString:@"4"]) {
		maxTicket = 45;
	}
	
	if ([ticketCount intValue] > maxTicket) {
		return YES;
	}
	
	return NO;
}

@end
