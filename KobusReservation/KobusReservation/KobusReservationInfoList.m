//
//  KobusReservationInfoList.m
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 23..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import "KobusReservationInfoList.h"

@implementation KobusReservationInfoList

@synthesize infoList,hideInfoList;

- (id)copyWithZone:(NSZone *)zone {
	
    KobusReservationInfoList *copy = [[KobusReservationInfoList allocWithZone:zone] init];
    if (copy){
        copy.infoList = [[infoList copy] autorelease];
		NSLog(@"%@",infoList);
		copy.hideInfoList = [[hideInfoList copy] autorelease];
		NSLog(@"%@",hideInfoList);
    }
	
    return copy; 
}

- (void)addInfoList:(NSArray*)objects
{
	
	[infoList addObject:objects];
}

- (void)addHideInfoList:(NSDictionary *)objects
{
	[hideInfoList addObject:objects];
}

- (NSDictionary*)getHideInfo:(NSInteger)index
{
	return [hideInfoList objectAtIndex:index];
}


- (NSString*)getTypeStringAtIndex:(NSInteger)index
{
	NSDictionary *dic = [hideInfoList objectAtIndex:index];
	NSMutableString *getTypeString = [NSMutableString string];
	for (int i=0; i<[dic count]; i++) {
		NSString *key = [[dic allKeys] objectAtIndex:i];
		NSString *value = [[dic allValues] objectAtIndex:i];
		if (i==[dic count]-1) 
			[getTypeString appendFormat:@"%@=%@",key,value];
		else
			[getTypeString appendFormat:@"%@=%@&",key,value];
		
	}
	return getTypeString;
}

- (id)init
{
	self = [super init];
	if (self) 
	{
		infoList = [[NSMutableArray alloc] init];
		hideInfoList = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[infoList release];
	[hideInfoList release];
	[super dealloc];
}

@end
