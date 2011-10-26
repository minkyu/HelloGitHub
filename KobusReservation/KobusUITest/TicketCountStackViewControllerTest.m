//
//  TicketCountStackViewControllerTest.m
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 25..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import "TicketCountStackViewControllerTest.h"

@implementation TicketCountStackViewControllerTest

- (void)viewDidLoad
{
	[super viewDidLoad];
	[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(show:) userInfo:nil repeats:NO];
}
- (void)show:(NSTimer*)timer
{
	[self selectTicket:adultTag index:1];
	[self addViewInSliderWithClass:nil];
}


@end
