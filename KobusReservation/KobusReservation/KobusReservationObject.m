//
//  KobusReservationObject.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 12..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "KobusReservationObject.h"

@implementation KobusReservationObject

@synthesize origin,destination,date,busClass,ticketCount;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSString*)description
{
	NSMutableString	*descriptionStr = [NSMutableString string];
	[descriptionStr appendFormat:@"Origin = %@\n",origin]; // 출발지
	[descriptionStr appendFormat:@"Destination = %@\n",destination];
	[descriptionStr appendFormat:@"Date = %@\n",date];
	[descriptionStr appendFormat:@"BusClass = %@\n",busClass];
	[descriptionStr appendFormat:@"TicketCount = %@\n",ticketCount];
	return descriptionStr;
}

@end
