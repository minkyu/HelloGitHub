//
//  ReservationInfoVIewController.m
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 22..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import "ReservationInfoVIewController.h"
#import "KobusReservationInfoList.h"
#import "BusSeatSelectViewController.h"

@implementation ReservationInfoVIewController
@synthesize infolist,recognizer;

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

- (void)removeRecognizer
{
	[recognizer removeTarget:self action:@selector(handleTapBehind:)];
	[self.view.window removeGestureRecognizer:recognizer];
}

- (void)dismissView:(id)sender
{
	[self removeRecognizer];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	self.recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)] autorelease];
	[recognizer setNumberOfTapsRequired:1];
	recognizer.cancelsTouchesInView = NO; //So the user can still interact with controls in the modal view
	[self.view.window addGestureRecognizer:recognizer];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:YES];
	[self removeRecognizer];
}

- (void)handleTapBehind:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
	{
		
		CGPoint location = [self.view convertPoint:[sender locationInView:nil] fromView:self.view.window]; //Passing nil gives us coordinates in the window
		
		if (![self.view pointInside:location withEvent:nil]&& ([self.navigationController topViewController] == self))
        {
			[self removeRecognizer];
			[self dismissModalViewControllerAnimated:YES];
        }
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	int selectRow = indexPath.row-1;
	if (selectRow<0) 
		return;
	NSString *usrStr = [NSString stringWithFormat:@"https://www.kobus.co.kr/web/03_reservation/reservation01_2.jsp?%@",
						[infolist getTypeStringAtIndex:selectRow]];
	NSLog(@"%@",usrStr);
//	NSString *usrStr = [NSString stringWithFormat:@"http://m.kobus.co.kr/web/m/reservation/sel_seat.jsp?%@",[infolist getTypeStringAtIndex:selectRow]];
	NSURL *url = [NSURL URLWithString:usrStr];
	__block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setCompletionBlock:^{
//		NSLog(@"%@",[request responseString]);
		
		BusSeatSelectViewController *viewcont = [[BusSeatSelectViewController alloc] initWithNibName:@"BusSeatSelectViewController" bundle:nil busClass:[infolist getBusClass:selectRow]];
		[self.navigationController pushViewController:viewcont animated:YES];
		[viewcont release];
		
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
