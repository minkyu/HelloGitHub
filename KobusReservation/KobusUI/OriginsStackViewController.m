//
//  OringinsViewController.m
//  StackScrollView
//
//  Created by kim hongjun on 11. 10. 11..
//  Copyright 2011년 __MyCompanyName__. All rights reserved.
//

#import "StackViewController.h"
#import "KobusReservationAppDelegate.h"


@implementation OriginsStackViewController


- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self.titleLabel setText:@"  출발지"];
		
		if ([[[KobusReservationAppDelegate instance] originData] count] == 0) {
			//로딩뺑뺑시작
			NSLog(@"로딩뺑뺑시작");
			[[NSNotificationCenter defaultCenter] addObserverForName:@"html분석이 끝났다." 
															  object:nil 
															   queue:nil 
														  usingBlock:^(NSNotification *noti) 
			 {
				 //로딩뺑뺑끝
				 NSLog(@"로딩뺑뺑끝");
				 [self.tableView reloadData];
				 [[NSNotificationCenter defaultCenter] removeObserver:self];
			 }];
		}	
	}
	return self;
}





#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[KobusReservationAppDelegate instance] originData] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text = [[[[KobusReservationAppDelegate instance] originData] allValues] objectAtIndex:[indexPath row]];
	cell.textLabel.textColor = [UIColor blackColor];
	
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	DestinationsStackViewController *dataViewController = [[DestinationsStackViewController alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
	dataViewController.selectedOrigin = [[[[KobusReservationAppDelegate instance] originData] allKeys] objectAtIndex:[indexPath row]];
	[[KobusReservationAppDelegate stackScrollViewController] addViewInSlider:dataViewController invokeByController:self isStackStartView:FALSE];
	[dataViewController release];
}


@end
