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

@synthesize responseData,Origins,Destinations,pushDatas;

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

- (NSString*)webDataEncoding
{
	NSString *webstring = [[[NSString alloc] initWithData:responseData encoding:EucKrEncoding] autorelease];
	NSAssert([webstring length], @"에러 발생");
	return webstring;
}


#pragma mark - Origins method

- (void)loadOrigins
{
	self.Origins = [[MutableSortedDictionary alloc]init];
	//responseData
	[self parseOrigins:[self webDataEncoding]];
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
	[self parseDestinations:[self webDataEncoding]];
}



// 목적지 파싱
// 멀티라인이 안먹네..


- (NSArray *) matchesOfDestinationsInString:(NSString*)aString
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"d.TER_FR.selectedIndex].value == \"([\\d]{3})\"[)] [{]([^}]*)[}]" 
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

//    NSLog(@"%d",[[self matchesOfDestinationsInString:aStr] count]);
	for (NSTextCheckingResult *match in [self matchesOfDestinationsInString:aStr]) {
		NSString *orgineStr = [aStr substringWithRange:[match rangeAtIndex:1]];// ([\\d]{3})
        NSString *fromCode = [aStr substringWithRange:[match rangeAtIndex:2]];// ([^}]*)
		
		[Destinations setValue:[self destinationForOrgine:fromCode] forKey:orgineStr];
	}

//	NSLog(@"%@",Destinations);
}


#pragma mark - NSURLConnection deletage

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
	pushDatas(Origins,Destinations);
}

#pragma mark - test code

-(void) makeSampleFileForTesting
{
	// 테스트용 파일을 만들 필요가 있을 때만 부른다.
	NSError *error = nil;
	[responseData writeToFile:@"~/KobusWebSampleInput__" options:NSDataWritingFileProtectionComplete error:&error];	
}


@end
