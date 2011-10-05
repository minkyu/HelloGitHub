//
//  KobusWeb.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 9. 30..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "KobusWeb.h"

#define EucKrEncoding 0x80000940

@implementation KobusWeb

@synthesize responseData,Origins,Destinations;

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
	[responseData release];
	[Origins release];
	[Destinations release];
	[super dealloc];
}



- (void)loadWeb
{
	self.responseData = [[NSMutableData alloc] init];
	
	NSURLRequest *request =	[NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://kobus.co.kr/web/index.jsp"]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)loadOrigins
{
	self.Origins = [[NSMutableDictionary alloc]init];
	//responseData
	[self parseOrigins:[self webDataEncoding]];
    
	
}

- (void)loadDestinations
{
	self.Destinations = [[NSMutableDictionary alloc]init];
	//responseData
	[self parseDestinations:[self webDataEncoding]];
}

// 출발지를 가져온다
- (void)parseOrigins:(NSString*)aStr {
	
	NSLog(@"parser start - %d", [aStr length]);
	NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<option value=\"([\\d]{3})\" >(.*)</option>"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *matches = [regex matchesInString:aStr options:0 range:NSMakeRange(0, [aStr length])];
    for (NSTextCheckingResult *match in matches) {
        // 지역코드
        NSString *locCode = [aStr substringWithRange:[match rangeAtIndex:1]];
        // 지역명
        NSString *locName = [aStr substringWithRange:[match rangeAtIndex:2]];
        
        [Origins setValue:locName forKey:locCode];
        NSLog(@"%@ = %@", locCode, locName);
        
                                        
    }
    
	NSLog(@"parser end");
}


// 목적지 파싱
// 멀티라인이 안먹네..
- (void)parseDestinations:(NSString*)aStr
{

    NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"d.TER_FR.selectedIndex].value == \"([\\d]{3})\"[)] [{]([^}]*)[}]" 
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
	NSAssert(regex, @"%@", error);
    NSArray *matches = [regex matchesInString:aStr options:0 range:NSMakeRange(0, [aStr length])];
    for (NSTextCheckingResult *match in matches) {
		NSString *orgineStr = [aStr substringWithRange:[match rangeAtIndex:1]];// ([\\d]{3})
        NSString *fromCode = [aStr substringWithRange:[match rangeAtIndex:2]];// ([^}]*)
		
		NSRegularExpression *subvalueregex = [NSRegularExpression regularExpressionWithPattern:@"].value	= \"([\\d]{3})\"" 
																				  options:NSRegularExpressionCaseInsensitive
																					error:&error];
		NSRegularExpression *subtextregex = [NSRegularExpression regularExpressionWithPattern:@"].text 	=  \"(.*)\"" 
																				  options:NSRegularExpressionCaseInsensitive
																					error:&error];
		NSArray *submatchesvalue = [subvalueregex matchesInString:fromCode options:0 range:NSMakeRange(0, [fromCode length])];
		NSArray *submatchestext = [subtextregex matchesInString:fromCode options:0 range:NSMakeRange(0, [fromCode length])];

		NSAssert([submatchesvalue count] == [submatchestext count], @"갯수가 틀림");
		NSMutableDictionary *destination = [[NSMutableDictionary alloc] init];
		for (int i = 0; i<[submatchesvalue count]; i++) {
			NSTextCheckingResult *subvalueresult = [submatchesvalue objectAtIndex:i];
			NSTextCheckingResult *subtextresult = [submatchestext objectAtIndex:i];
			
			NSString *subvalue = [fromCode substringWithRange:[subvalueresult rangeAtIndex:1]];
			NSString *subtext = [fromCode substringWithRange:[subtextresult rangeAtIndex:1]];
			[destination setValue:subtext forKey:subvalue];
			
		}
		[Destinations setValue:destination forKey:orgineStr];
		[destination release];
    }
	NSLog(@"%@",Destinations);
    NSLog(@"parse end");
}

- (NSString*)webDataEncoding
{
	NSString *webstring = [[[NSString alloc] initWithData:responseData encoding:EucKrEncoding] autorelease];
	NSAssert([webstring length], @"에러 발생");
	return webstring;
}

#pragma - NSURLConnection deletage

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSString * errorString = [NSString stringWithFormat:@"Error code %i", [error code]];
	
    UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" 
														  message:errorString delegate:self 
												cancelButtonTitle:@"OK" 
												otherButtonTitles:nil];
	
    [errorAlert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
//	NSString *webstring = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
//	NSLog(@"%@",[self webDataEncoding]);
	[connection release];
	
	[self loadOrigins];
	[self loadDestinations];
}

@end
