//
//  DestinationsStackViewController.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 11..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "StackViewController.h"
#import "KobusReservationAppDelegate.h"


@implementation DestinationsStackViewController
@synthesize selectedOrigin;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self.titleLabel setText:@"  도착지"];
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
	return [[[[KobusReservationAppDelegate instance] destinationData] objectForKey:selectedOrigin] count];
//    return [[[[KobusReservationAppDelegate instance] destinationData] objectForKey: ] count];
	
//	selectedOrigin
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	
	cell.textLabel.text = [[[[[KobusReservationAppDelegate instance] destinationData] objectForKey:selectedOrigin] allValues] objectAtIndex:indexPath.row];
	cell.textLabel.textColor = [UIColor blackColor];
	
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

// 목적지 값을 저장하고 날짜 선택 뷰를 불러 온다
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	DateStackViewController *dataViewController = [[DateStackViewController alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
	[[KobusReservationAppDelegate stackScrollViewController] addViewInSlider:dataViewController invokeByController:self isStackStartView:FALSE];
	[dataViewController release];
	
	// 목적지 명
	id destination = [[[[[KobusReservationAppDelegate instance] destinationData] objectForKey:selectedOrigin] allValues] objectAtIndex:[indexPath row]];
	[self postNoticationReservation:@"KobusReservation" value:destination key:@"destination"];
	
	// 목적지 코드
	id destination_code = [[[[[KobusReservationAppDelegate instance] destinationData] objectForKey:selectedOrigin] allKeys] objectAtIndex:[indexPath row]];
	[self postNoticationReservation:@"KobusReservation" value:destination_code key:@"TER_TO"];
}


@end
