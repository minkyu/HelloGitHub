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
//사이트에 사용되는 param
@synthesize TER_FR, TER_TO, Tim_data_Year, Tim_data_Month, Tim_data_Day, TIM_TIM_I, BUS_GRA_I, pCnt_050, pCnt_100;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
		pCnt_100 = @"0";
		pCnt_050 = @"0";
    }
    
    return self;
}

- (NSString*)description
{
	NSMutableString	*descriptionStr = [NSMutableString string];
//	[descriptionStr appendFormat:@"Origin = %@\n",origin]; // 출발지
//	[descriptionStr appendFormat:@"Destination = %@\n",destination];
//	[descriptionStr appendFormat:@"Date = %@\n",date];
//	[descriptionStr appendFormat:@"BusClass = %@\n",busClass];
//	[descriptionStr appendFormat:@"TicketCount = %@\n",ticketCount];
//	
	
	[descriptionStr appendFormat:@"\nTER_FR = %@\n", TER_FR];
	[descriptionStr appendFormat:@"TER_TO = %@\n", TER_TO];
	[descriptionStr appendFormat:@"Tim_data_Year = %@\n", Tim_data_Year];
	[descriptionStr appendFormat:@"Tim_data_Month = %@\n", Tim_data_Month];
	[descriptionStr appendFormat:@"Tim_data_Day = %@\n", Tim_data_Day];
	[descriptionStr appendFormat:@"TIM_TIM_I = %@\n", TIM_TIM_I];
	[descriptionStr appendFormat:@"BUS_GRA_I = %@\n", BUS_GRA_I];
	[descriptionStr appendFormat:@"pCnt_100 = %@\n", pCnt_100];
	[descriptionStr appendFormat:@"pCnt_050 = %@\n", pCnt_050];
	
	return descriptionStr;
}


// 이제 없애도 될듯
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
	if([TER_TO isEqualToString:@"310"] || [TER_TO isEqualToString:@"020"] 
	   || [TER_TO isEqualToString:@"032"] || [TER_TO isEqualToString:@"190"] || [TER_TO isEqualToString:@"456"])
		return YES;
	return NO;
}

// 티켓 수 확인	
- (BOOL)requestedNoTicket
{
	// TODO null처리 
	if (([pCnt_100 intValue] + [pCnt_100 intValue]) < 1) return YES;
	return NO;
}

// 티켓이 좌석보다 초과하는지 확인
// 고급 27석 일반 45석
// TODO 어른티켓 아이티켓 분리 시 아래 함수는 합산을 기준으로 변경
- (BOOL)requestedExcessTicket
{

	int maxTicket = 27;
	if ([BUS_GRA_I isEqualToString:@"0"] || [BUS_GRA_I isEqualToString:@"1"] || [BUS_GRA_I isEqualToString:@"4"]) {
		maxTicket = 45;
	}
	
	if (([pCnt_100 intValue] + [pCnt_100 intValue]) > maxTicket) {
		return YES;
	}
	
	return NO;
}

@end
