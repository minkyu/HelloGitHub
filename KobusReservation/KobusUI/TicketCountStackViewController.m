//
//  TicketCountStackViewController.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 12..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "TicketCountStackViewController.h"


@implementation TicketCountStackViewController

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self.titleLabel setText:@"  매수"];
		
	}
	return self;
}

@end
