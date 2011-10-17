//
//  KobusWeb.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 9. 30..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "KobusWeb.h"
//#define EucKrEncoding 0x80000940
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
	
	[self loadFile];
	[self processData];
}

-(void) processData
{
	[self loadOrigins];
	[self loadDestinations];
	NSLog(@"분석끝");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"html분석이 끝났다." object:nil];
}


- (void)loadKoBusWeb
{
//	NSURL *url = [NSURL URLWithString:@"http://kobus.co.kr/web/index.jsp"];
	NSURL *url = [NSURL URLWithString:@"http://m.kobus.co.kr/web/m/reservation/ins_reservation.jsp"];
	__block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setCompletionBlock:^{
		self.responseString = [request responseString];
		[self processData];
		
	}];
	[request setFailedBlock:^{
		[self failWithError:[request error]];
	}];
	[request startAsynchronous];
	
}

#pragma mark - Origins method

- (void)loadOrigins
{
	self.Origins = [[MutableSortedDictionary alloc]init];
	//responseData
	[self parseOrigins:responseString];
}

// 출발지를 가져온다
- (NSArray *) matchesOfOriginsInString:(NSString*)aString
{
	NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<option value=\"([\\d]{3})\" >(.*)</option>"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
	return [regex matchesInString:aString options:0 range:NSMakeRange(0, [aString length])];	
}

- (void)parseOrigins:(NSString*)aStr {
	
    for (NSTextCheckingResult *match in [self matchesOfOriginsInString:aStr]) {
        // 지역코드
        NSString *locCode = [aStr substringWithRange:[match rangeAtIndex:1]];
        // 지역명
        NSString *locName = [aStr substringWithRange:[match rangeAtIndex:2]];
        
        [Origins setValue:locName forKey:locCode];
        
		
    }
    
}


#pragma mark - Destinations method


- (void)loadDestinations
{
	self.Destinations = [[MutableSortedDictionary alloc]init];
	//responseData
	[self parseDestinations:responseString];
}


- (NSArray *) matchesOfDestinationsInString:(NSString*)aString
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression 
								  regularExpressionWithPattern:@"d.TER_FR.selectedIndex].value == \"([\\d]{3})\"[)] [{]([^}]*)[}]" 
								  options:NSRegularExpressionCaseInsensitive + NSRegularExpressionDotMatchesLineSeparators
								  error:&error];
	NSAssert(regex, @"%@", error);
	return [regex matchesInString:aString options:0 range:NSMakeRange(0, [aString length])];	
}

- (SortedDictionary*)destinationForOrgine:(NSString*)fromCode
{
	NSError *error = NULL;	
	NSRegularExpression *subvalueregex = [NSRegularExpression regularExpressionWithPattern:@"].value	= \"([\\d]{3})\"" 
																				   options:NSRegularExpressionCaseInsensitive
																					 error:&error];
	NSRegularExpression *subtextregex = [NSRegularExpression regularExpressionWithPattern:@"].text 	=  \"(.*)\"" 
																				  options:NSRegularExpressionCaseInsensitive
																					error:&error];
	NSArray *submatchesvalue = [subvalueregex matchesInString:fromCode options:0 range:NSMakeRange(0, [fromCode length])];
	NSArray *submatchestext = [subtextregex matchesInString:fromCode options:0 range:NSMakeRange(0, [fromCode length])];
	
	NSAssert([submatchesvalue count] == [submatchestext count], @"갯수가 틀림");
	MutableSortedDictionary *destination = [[MutableSortedDictionary alloc] init];
	for (int i = 0; i<[submatchesvalue count]; i++) {
		NSTextCheckingResult *subvalueresult = [submatchesvalue objectAtIndex:i];
		NSTextCheckingResult *subtextresult = [submatchestext objectAtIndex:i];
		
		NSString *subvalue = [fromCode substringWithRange:[subvalueresult rangeAtIndex:1]];
		NSString *subtext = [fromCode substringWithRange:[subtextresult rangeAtIndex:1]];
		[destination setValue:subtext forKey:subvalue];
		
	}
	return [destination autorelease];
}

- (void)parseDestinations:(NSString*)aStr
{

	for (NSTextCheckingResult *match in [self matchesOfDestinationsInString:aStr]) {
		NSString *orgineStr = [aStr substringWithRange:[match rangeAtIndex:1]];// ([\\d]{3})
        NSString *fromCode = [aStr substringWithRange:[match rangeAtIndex:2]];// ([^}]*)
		
		[Destinations setValue:[self destinationForOrgine:fromCode] forKey:orgineStr];
	}

}

#pragma mark - ReservationQuery

- (void)sendReservationInfoQueryArray:(NSArray*)params
{
	NSURL *url = [NSURL URLWithString:@"http://m.kobus.co.kr/web/m/reservation/sch_bus.jsp"];
	//	NSURL *url = [NSURL URLWithString:@"http://kobus.co.kr/web/reservation/sch_bus.jsp"];
	__block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setStringEncoding:EucKrEncoding];
	for (NSDictionary* dic in params) 
	{
		[request addPostValue:[[dic allValues] objectAtIndex:0] forKey:[[dic allKeys] objectAtIndex:0]];
	}
	
	
	[request setCompletionBlock:^{
		NSLog(@"%@",[request responseString]);
	} ];
	[request setFailedBlock:^{
		NSLog(@"으아니!");
	}];
	[request startAsynchronous];
	
}

- (void)sendReservationInfoQuery:(NSDictionary*)params
{
	NSURL *url = [NSURL URLWithString:@"http://m.kobus.co.kr/web/m/reservation/sch_bus.jsp"];
	__block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setStringEncoding:EucKrEncoding];
	for (NSString* key in params) {
		[request addPostValue:[params objectForKey:key] forKey:key];
	}
	[request setCompletionBlock:^{
		NSLog(@"%@",[request responseString]);
	} ];
	[request setFailedBlock:^{
		NSLog(@"으아니!");
	}];
	[request startAsynchronous];
	
}

- (void)sendReservationInfoQueryString:(NSString*)params
{
	NSString *usrStr = [NSString stringWithFormat:@"http://m.kobus.co.kr/web/m/reservation/sch_bus.jsp?%@",params];
	NSURL *url = [NSURL URLWithString:usrStr];
	__block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	
	
	
	[request setCompletionBlock:^{
		NSLog(@"%@",[request responseString]);
	} ];
	[request setFailedBlock:^{
		NSLog(@"으아니!");
	}];
	[request startAsynchronous];
}

@end
