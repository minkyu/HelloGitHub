//
//  KobusWeb.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 9. 30..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "KobusWeb.h"
#import "KobusRouteWeb.h"

#define EucKrEncoding -2147481280

#define TimeTagIndex 1
#define ClassTagIndex 2
#define CompanyTagIndex 3
#define TicketCountTagIndex 4


@implementation KobusWeb

@synthesize responseString,Origins,Destinations;

- (id)init
{
    self = [super init];
    if (self) 
	{

    }
    
    return self;
}

- (void)dealloc
{
	[responseString release];
	[Origins release];
	[Destinations release];
	[super dealloc];
}

-(void) loadFile
{
	NSString* file = [[NSBundle mainBundle] pathForResource:@"KobusWebSampleInput" ofType:@"data"];
	self.responseString = [[[NSString alloc] initWithData:[NSMutableData dataWithContentsOfFile:file]
												 encoding:EucKrEncoding] autorelease];
}

- (void)failWithError:(NSError *)error
{
    NSString * errorString = [NSString stringWithFormat:@"Error code %i\nTest data will be loaded.", [error code]];
	
    UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" 
														  message:errorString delegate:self 
												cancelButtonTitle:@"OK" 
												otherButtonTitles:nil];
	
    [errorAlert show];
	[errorAlert autorelease];
	
	[self loadFile];
	[self processRouteData];
}

#pragma mark - RouteData

- (void)loadKoBusWeb
{
	NSURL *url = [NSURL URLWithString:@"http://m.kobus.co.kr/web/m/reservation/ins_reservation.jsp"];
	__block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setCompletionBlock:^{
		self.responseString = [request responseString];
		[self processRouteData];
		
	}];
	[request setFailedBlock:^{
		[self failWithError:[request error]];
	}];
	[request startAsynchronous];
	
}


-(void) processRouteData
{
	KobusRouteWeb *routeWeb = [[[KobusRouteWeb  alloc] init] autorelease];
	self.Origins = [routeWeb parseOrigins:responseString];
	self.Destinations = [routeWeb parseDestinations:responseString];
	NSLog(@"분석끝");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"html분석이 끝났다." object:nil];
}

#pragma mark - ReservationQuery

- (void)sendReservationInfoUsingPostMethod:(KobusReservationObject*)resvObj
{
	NSString *schStr = [NSString stringWithFormat:@"http://m.kobus.co.kr/web/m/reservation/sch_bus.jsp"];
	NSURL *url = [NSURL URLWithString:schStr];
	__block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	
	[request addRequestHeader:@"Referer" value:@"http://m.kobus.co.kr/web/m/reservation/ins_reservation.jsp"];
	[request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
	[request addRequestHeader:@"User-Agent" value:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/534.51.22 (KHTML, like Gecko) Version/5.1.1 Safari/534.51.22"];
	[request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
	[request addRequestHeader:@"Accept-Encoding" value:@"gzip, deflate"];
	[request addRequestHeader:@"Origin" value:@"http://m.bus.co.kr"];
	[request addRequestHeader:@"Accept-Language" value:@"en-us"];
//	[request 
	
	[request setPostValue:resvObj.TER_FR forKey:@"TER_FR"];
	[request setPostValue:resvObj.TER_TO forKey:@"TER_TO"];
	[request setPostValue:resvObj.Tim_date_Year forKey:@"Tim_date_Year"];
	[request setPostValue:resvObj.Tim_date_Month forKey:@"Tim_date_Month"];
	[request setPostValue:resvObj.Tim_date_Day forKey:@"Tim_date_Day"];
	[request setPostValue:resvObj.TIM_TIM_I forKey:@"TIM_TIM_I"];
	[request setPostValue:resvObj.BUS_GRA_I forKey:@"BUS_GRA_I"];
	[request setPostValue:resvObj.pCnt_100 forKey:@"pCnt_100"];
	[request setPostValue:resvObj.pCnt_050 forKey:@"pCnt_050"];


	
	[request setCompletionBlock:^{
		self.responseString = [request responseString];
		[self processReservationInfo];
	} ];
	[request setFailedBlock:^{
		[self failWithError:[request error]];
	}];
	[request startAsynchronous];
	
	
	
	
}

- (void)sendReservationInfoQueryString:(NSString*)params withInfoList:(infoList)infolist
{
	NSString *usrStr = [NSString stringWithFormat:@"http://m.kobus.co.kr/web/m/reservation/sch_bus.jsp?%@",params];
	NSURL *url = [NSURL URLWithString:usrStr];
	__block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setCompletionBlock:^{
		self.responseString = [request responseString];
//		[self processReservationInfo:[request responseData]];
		infolist([self processReservationInfoList:[request responseData]]);
	} ];
	[request setFailedBlock:^{
		[self failWithError:[request error]];
	}];
	[request startAsynchronous];
}

- (void)sendReservationInfoQueryString:(NSString*)params
{
	NSString *usrStr = [NSString stringWithFormat:@"http://m.kobus.co.kr/web/m/reservation/sch_bus.jsp?%@",params];
	NSURL *url = [NSURL URLWithString:usrStr];
	__block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setCompletionBlock:^{
		self.responseString = [request responseString];
		[self processReservationInfo:[request responseData]];
	} ];
	[request setFailedBlock:^{
		[self failWithError:[request error]];
	}];
	[request startAsynchronous];
}

- (void)processReservationInfo
{
	NSLog(@"%@", responseString);	
}

- (void)processReservationInfo:(NSData*)responseData
{
	TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:responseData];
	int seatformcount = 0;
	
	while (42) {
		//<form name="SeatForm
		TFHppleElement *seatForm = [hpple peekAtSearchWithXPathQuery:[NSString stringWithFormat:@"//form[@name='SeatForm%d']",seatformcount++]];
		if (!seatForm) {
			break;
		}
		//<tr ... table row
		TFHppleElement *tr = [seatForm firstChild];
		//<td ... table data
		NSArray *tds = [tr children];
		
		NSLog(@"%@",[[tds objectAtIndex:TimeTagIndex] content]);
		NSLog(@"%@",[[tds objectAtIndex:ClassTagIndex] content]);
		NSLog(@"%@",[[tds objectAtIndex:CompanyTagIndex] content]);
		NSLog(@"%@",[[tds objectAtIndex:TicketCountTagIndex] content]);
		for (int i = TicketCountTagIndex+1; i<[tds count]; i++) {
			if ([[[tds objectAtIndex:i] tagName] isEqualToString:@"input"]) {
				NSLog(@"%@",[[tds objectAtIndex:i] objectForKey:@"name"]);
				NSLog(@"%@",[[tds objectAtIndex:i] objectForKey:@"value"]);
			}
			else
				break;
		}
	}
	[hpple release];
}

- (KobusReservationInfoList*)processReservationInfoList:(NSData*)responseData
{
	TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:responseData];
	KobusReservationInfoList *infolist = [[KobusReservationInfoList alloc] init];
	int seatformcount = 0;
	while (42) {
		//<form name="SeatForm
		TFHppleElement *seatForm = [hpple peekAtSearchWithXPathQuery:[NSString stringWithFormat:@"//form[@name='SeatForm%d']",seatformcount++]];
		if (!seatForm) {
			break;
		}
		//<tr ... table row
		TFHppleElement *tr = [seatForm firstChild];
		//<td ... table data
		NSArray *tds = [tr children];
		NSMutableArray *info = [NSMutableArray new];
		[info addObject:[[tds objectAtIndex:TimeTagIndex] content]];
		[info addObject:[[tds objectAtIndex:ClassTagIndex] content]];
		[info addObject:[[tds objectAtIndex:CompanyTagIndex] content]];
		[info addObject:[[tds objectAtIndex:TicketCountTagIndex] content]];
		[infolist addInfoList:info];
		
		NSMutableDictionary	*hideinfo = [NSMutableDictionary new];
		for (int i = TicketCountTagIndex+1; i<[tds count]; i++) {
			if ([[[tds objectAtIndex:i] tagName] isEqualToString:@"input"]) {
				[hideinfo setValue:[[tds objectAtIndex:i] objectForKey:@"value"] forKey:[[tds objectAtIndex:i] objectForKey:@"name"]];
			}
			else
				break;
		}
		[infolist addHideInfoList:hideinfo];
		
//		NSLog(@"%@",[[tds objectAtIndex:TimeTagIndex] content]);
//		NSLog(@"%@",[[tds objectAtIndex:ClassTagIndex] content]);
//		NSLog(@"%@",[[tds objectAtIndex:CompanyTagIndex] content]);
//		NSLog(@"%@",[[tds objectAtIndex:TicketCountTagIndex] content]);
//		for (int i = TicketCountTagIndex+1; i<[tds count]; i++) {
//			if ([[[tds objectAtIndex:i] tagName] isEqualToString:@"input"]) {
//				NSLog(@"%@",[[tds objectAtIndex:i] objectForKey:@"name"]);
//				NSLog(@"%@",[[tds objectAtIndex:i] objectForKey:@"value"]);
//			}
//			else
//				break;
//		}
	}
	[hpple release];
	return infolist;
}

@end
