//
//  KobusRouteWeb.m
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 17..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import "KobusRouteWeb.h"

@implementation KobusRouteWeb

#pragma mark - Origins method

// 출발지를 가져온다
- (NSArray *) matchesOfOriginsInString:(NSString*)aString
{
	NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<option value=\"([\\d]{3})\" >(.*)</option>"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
	return [regex matchesInString:aString options:0 range:NSMakeRange(0, [aString length])];	
}

- (MutableSortedDictionary *)parseOrigins:(NSString*)aStr 
{
	MutableSortedDictionary *Origins = [[MutableSortedDictionary alloc] init];
    for (NSTextCheckingResult *match in [self matchesOfOriginsInString:aStr]) {
        // 지역코드
        NSString *locCode = [aStr substringWithRange:[match rangeAtIndex:1]];
        // 지역명
        NSString *locName = [aStr substringWithRange:[match rangeAtIndex:2]];
        
        [Origins setValue:locName forKey:locCode];
        
		
    }
	return [Origins autorelease];
}

#pragma mark - Destinations method


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

- (MutableSortedDictionary*)parseDestinations:(NSString*)aStr
{
	MutableSortedDictionary *Destinations = [[MutableSortedDictionary alloc]init];
	for (NSTextCheckingResult *match in [self matchesOfDestinationsInString:aStr]) {
		NSString *orgineStr = [aStr substringWithRange:[match rangeAtIndex:1]];// ([\\d]{3})
        NSString *fromCode = [aStr substringWithRange:[match rangeAtIndex:2]];// ([^}]*)
		
		[Destinations setValue:[self destinationForOrgine:fromCode] forKey:orgineStr];
	}
	return [Destinations autorelease];
}


@end
