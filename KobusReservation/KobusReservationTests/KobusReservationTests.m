//
//  KobusReservationTests.m
//  KobusReservationTests
//
//  Created by 오 화종 on 11. 09. 30.
//  Copyright 2011년 앱달. All rights reserved.
//

#import "KobusReservationTests.h"
#import "KobusWeb.h"

@implementation KobusWebTests

- (void)setUp
{
    [super setUp];
    kobusWeb = [[KobusWeb alloc] init];
	kobusWeb.responseData = [NSMutableData dataWithContentsOfFile:@""];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [kobusWeb release];
    [super tearDown];
}

- (void)testLoadOrigins
{
	[kobusWeb loadWeb];
}

@end
