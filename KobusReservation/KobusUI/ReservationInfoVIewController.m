//
//  ReservationInfoVIewController.m
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 22..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import "ReservationInfoVIewController.h"
#import "KobusReservationInfoList.h"

@implementation ReservationInfoVIewController
@synthesize infolist;

- (id)initWithInfoList:(KobusReservationInfoList*)aInfoList
{
    self = [super init];
    if (self) {
        // Custom initialization
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
												   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
												   target:self
												   action:@selector(dismissView:)] autorelease];
		self.infolist = aInfoList;
		NSMutableArray *gridData = [NSMutableArray arrayWithArray:infolist.infoList];
		[gridData insertObject:[NSArray arrayWithObjects:@"출발시간",@"등급",@"회사",@"잔여좌석", nil] atIndex:0];
		self.GridData = gridData;
		
    }
    return self;
}

- (void)dismissView:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
	[recognizer setNumberOfTapsRequired:1];
	recognizer.cancelsTouchesInView = NO; //So the user can still interact with controls in the modal view
	[self.view.window addGestureRecognizer:recognizer];
	[recognizer release];
}

- (void)handleTapBehind:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
	{
		CGPoint location = [sender locationInView:nil]; //Passing nil gives us coordinates in the window
		
		//Then we convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.
		
        if (![self.view pointInside:[self.view convertPoint:location fromView:self.view.window] withEvent:nil]) 
        {
			
			[sender removeTarget:self action:@selector(handleTapBehind:)];
			[self.view.window removeGestureRecognizer:sender];
			[self dismissModalViewControllerAnimated:YES];
        }
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	int selectRow = indexPath.row-1;
	if (selectRow<0) 
		return;
	NSLog(@"%@",[infolist getTypeStringAtIndex:selectRow]);
	
	NSString *usrStr = [NSString stringWithFormat:@"https://www.kobus.co.kr/web/03_reservation/reservation01_2.jsp?%@",[infolist getTypeStringAtIndex:selectRow]];
	NSLog(@"%@",usrStr);
//	NSString *usrStr = [NSString stringWithFormat:@"http://m.kobus.co.kr/web/m/reservation/sel_seat.jsp?%@",[infolist getTypeStringAtIndex:selectRow]];
	NSURL *url = [NSURL URLWithString:usrStr];
	__block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setCompletionBlock:^{
		NSLog(@"%@",[request responseString]);
	} ];
	[request setFailedBlock:^{
		NSLog(@"%@",[request error]);
	}];
	[request startAsynchronous];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
