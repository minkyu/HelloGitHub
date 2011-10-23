//
//  ClassStackViewController.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 12..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "StackViewController.h"
#import "KobusReservationAppDelegate.h"


const int padding = 10;

@implementation ClassStackViewController


- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self.titleLabel setText:@"  등급"];
		CGSize buttonsize = CGSizeMake(frame.size.width/3, frame.size.width/3);
		
		
		[self addButton:@"일반고속" 
				 origin:CGPointMake(padding,titleHeight+boundaryHeight+padding) 
				   size:buttonsize
					tag:10];
		
		[self addButton:@"우등고속"
				 origin:CGPointMake(padding+padding+buttonsize.width,titleHeight+boundaryHeight+padding) 
				   size:buttonsize
					tag:20];
		
		[self addButton:@"심야우등" 
				 origin:CGPointMake(padding,titleHeight+boundaryHeight+padding+buttonsize.height+padding) 
				   size:buttonsize
					tag:30];
		
		[self addButton:@"심야고속" 
				 origin:CGPointMake(padding+padding+buttonsize.width,titleHeight+boundaryHeight+padding+buttonsize.height+padding) 
				   size:buttonsize
					tag:40];
		
		[self addButton:@"전체등급" 
				 origin:CGPointMake((padding+padding+buttonsize.width)/2,titleHeight+boundaryHeight+padding+buttonsize.height+padding+buttonsize.height+padding) 
				   size:buttonsize
					tag:50];
		
		
	}
	return self;
}

- (void)selectedButton:(UIButton*)button
{
	
	//stackScrollViewController에 tag버그 있음 1,2,3내부적으로 사용해서 문제가 됨
	
	TicketCountStackViewController *dataViewController = [[TicketCountStackViewController alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
	[[KobusReservationAppDelegate stackScrollViewController] addViewInSlider:dataViewController invokeByController:self isStackStartView:FALSE];
	[dataViewController release];
	

	[self postNoticationReservation:@"KobusReservation" value:button.titleLabel.text key:@"busClass"];
	
	NSString *busGrade = [[NSNumber numberWithInt:((button.tag / 10)%5)] stringValue];

	// 사이트 param
	[self postNoticationReservation:@"KobusReservation" value:busGrade key:@"BUS_GRA_I"];
}

@end
