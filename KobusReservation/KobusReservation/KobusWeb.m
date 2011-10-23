//
//  KobusWeb.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 9. 30..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "KobusWeb.h"
#import "KobusRouteParser.h"
#import "KobusReservationInfoParser.h"

#define EucKrEncoding -2147481280



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
	self.Origins = [KobusRouteParser parseOrigins:responseString];
	self.Destinations = [KobusRouteParser parseDestinations:responseString];
	NSLog(@"분석끝");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"html분석이 끝났다." object:nil];
}

#pragma mark - ReservationQuery

- (void)sendReservationInfoQueryString:(NSString*)params withInfoList:(infoList)infolist
{
	NSString *usrStr = [NSString stringWithFormat:@"http://m.kobus.co.kr/web/m/reservation/sch_bus.jsp?%@",params];
	NSURL *url = [NSURL URLWithString:usrStr];
	__block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setCompletionBlock:^{
		infolist([KobusReservationInfoParser parsing:[request responseData]]);
	} ];
	[request setFailedBlock:^{
		[self failWithError:[request error]];
	}];
	[request startAsynchronous];
}


@end
