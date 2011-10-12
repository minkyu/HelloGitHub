//
//  DateStackViewController.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 11..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "DateStackViewController.h"
#import "KobusReservationAppDelegate.h"
#import "RootViewController.h"
#import "StackScrollViewController.h"
#import "ClassStackViewController.h"

@implementation DateDataSource

@synthesize dates;

- (id)init
{
	self = [super init];
	if (self) 
	{
		NSMutableArray *arry = [[NSMutableArray alloc] init];
		for (int i = 0; i < 24; i++) {
			[arry addObject:[NSString stringWithFormat:@"%02d:00",i]];
		}
		self.dates = [NSArray arrayWithArray:arry];
	}
	
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"MyCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	cell.textLabel.text = [dates objectAtIndex:indexPath.row];
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [dates count];
}

@end


const int kalViewWidth = 322;

@implementation DateStackViewController

@synthesize kal,dataSource;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self.titleLabel setText:@"  날짜/시간"];
		
		kal = [[KalViewController alloc] initwithFrame:CGRectMake(10, 
																  titleHeight+boundaryHeight, 
																  kalViewWidth, 
																  frame.size.height- (titleHeight+boundaryHeight))];
		[self.view addSubview:kal.view];
		
		kal.delegate = self;
		self.dataSource = [[DateDataSource alloc] init];
		kal.dataSource = dataSource;
		
		
	}
	return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	
	NSDateFormatter *dateFromat = [[[NSDateFormatter alloc] init] autorelease];
	[dateFromat setDateFormat:@"yyyy-MM-dd"];
	NSString *theDate = [dateFromat stringFromDate:kal.selectedDate];
	NSString *theTime = [dataSource.dates objectAtIndex:indexPath.row];
	NSLog(@"%@ %@",theDate,theTime);
	
	ClassStackViewController *dataViewController = [[ClassStackViewController alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
	[[KobusReservationAppDelegate instance].rootViewController.stackScrollViewController addViewInSlider:dataViewController invokeByController:self isStackStartView:FALSE];
	[dataViewController release];
	
	/*
	 
	 NSString *dateStr = @"20081122";
	 
	 // Convert string to date object
	 NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	 [dateFormat setDateFormat:@"HH"];
	 NSDate *date = [dateFormat dateFromString:dateStr];
	 
	 
	 
	 // 현재 날짜와 시간.
	 NSDate *now = [[NSDate alloc] init];
	 
	 // 날짜 포맷.
	 NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	 [dateFormat setDateFormat:@"yyyy-MM-dd"];
	 
	 // 시간 포맷.
	 NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	 [timeFormat setDateFormat:@"HH:mm:ss"];
	 
	 NSString *theDate = [dateFormat stringFromDate:now];
	 NSString *theTime = [timeFormat stringFromDate:now];
	 NSString *updated = @"Updated: ";
	 updated = [updated stringByAppendingString:theDate];
	 updated = [updated stringByAppendingString:@" "];
	 updated = [updated stringByAppendingString:theTime];
	 
	 NSLog(@"Updated: %@", updated);
	 
	 [dateFormat release];
	 [timeFormat release];
	 [now release];
	 
	 */
}
@end

