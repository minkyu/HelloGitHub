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

- (void)setUp
{
    [super setUp];
    kobusWeb = [[KobusWeb alloc] init];
	//NSString *path = @"KobusReservation/KobusReservation/KobusWebSampleInput.data";
	NSString *path = [[NSBundle mainBundle] pathForResource:@"KobusWebSampleInput" ofType:@"data"];
	NSLog(@"path=%@",path);
	kobusWeb.responseData = [NSMutableData dataWithContentsOfFile: path];

	//[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	//[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"KobusReservation.sqlite"];
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

- (void)testLoadOrigins
{
	[kobusWeb loadOrigins];
}

@end
