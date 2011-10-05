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


@end
