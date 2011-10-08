//
//  KobusReservationTests.m
//  KobusReservationTests
//
//  Created by 오 화종 on 11. 09. 30.
//  Copyright 2011년 앱달. All rights reserved.
//

#import "KobusWebTests.h"
#import "KobusWeb.h"

@implementation KobusWebTests

-(NSBundle*) getTestBundle
{
	for(NSBundle *each in [NSBundle allBundles]){
		if([[each bundlePath] hasSuffix:@".octest"]) return each;
	}
	return nil;
}

- (void)setUp
{
    [super setUp];
    kobusWeb = [[KobusWeb alloc] init];
	NSString *path = [[self getTestBundle] pathForResource:@"KobusWebSampleInput" ofType:@"data"];
	NSLog(@"path=%@",path);
	kobusWeb.responseData = [NSMutableData dataWithContentsOfFile: path];
}

- (void)tearDown
{
    // Tear-down code here.
    [kobusWeb release];
    [super tearDown];
}

-(void) testSetUp
{
	STAssertNotNil(kobusWeb, nil);
	STAssertNotNil(kobusWeb.responseData, nil);
}

- (void)testMatchesOfOriginsInString
{
	NSArray *matches = [kobusWeb matchesOfOriginsInString: [kobusWeb webDataEncoding]];
	STAssertEquals((int)124, (int)[matches count], nil);;
	NSTextCheckingResult *match = [matches objectAtIndex:3];
	STAssertEqualObjects(@"355", [[kobusWeb webDataEncoding] substringWithRange: [match rangeAtIndex:1]], nil);
	STAssertEqualObjects(@"고대홍대[355]", [[kobusWeb webDataEncoding] substringWithRange: [match rangeAtIndex:2]], nil);
}

- (void)testMatchesOfDestinationsInString
{
	NSArray *matches = [kobusWeb matchesOfDestinationsInString: [kobusWeb webDataEncoding]];
	STAssertEquals((int)124, (int)[matches count], nil);;
	NSTextCheckingResult *match = [matches objectAtIndex:0];
	STAssertEqualObjects(@"200", [[kobusWeb webDataEncoding] substringWithRange: [match rangeAtIndex:1]], nil);
}

-(void)testDestinationForOrgine
{
	NSString *aStr = [kobusWeb webDataEncoding];
	NSTextCheckingResult *match = [[kobusWeb matchesOfDestinationsInString:aStr] objectAtIndex: 4];
	NSString *orgineStr = [aStr substringWithRange:[match rangeAtIndex:1]];// ([\\d]{3})
	NSString *fromCode = [aStr substringWithRange:[match rangeAtIndex:2]];// ([^}]*)
	STAssertEqualObjects(@"115", orgineStr, nil);
	NSError *error = nil;
	STAssertEqualObjects([NSString stringWithContentsOfFile:[[self getTestBundle] pathForResource:@"Sample115" ofType:@"data"] encoding:NSUTF8StringEncoding error:&error], fromCode, nil);
	SortedDictionary *sd = [kobusWeb destinationForOrgine:fromCode];
	NSArray *destinations = [sd allValues];
	STAssertEquals((int)5, (int)[destinations count], nil);
	STAssertEqualObjects(@"강릉    [200]",[destinations objectAtIndex:0],nil);
	STAssertEqualObjects(@"횡성(하)휴게소[238]",[destinations objectAtIndex:1],nil);
	STAssertEqualObjects(@"정안(하)휴게소[315]",[destinations objectAtIndex:2],nil);
	STAssertEqualObjects(@"광주    [500]",[destinations objectAtIndex:3],nil);
	STAssertEqualObjects(@"전주    [602]",[destinations objectAtIndex:4],nil);
}


@end
