//
//  DateStackViewController.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 11..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "StackViewController.h"
#import "KobusReservationAppDelegate.h"


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
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
	
	cell.textLabel.text = [dates objectAtIndex:indexPath.row];
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [dates count];
}

- (NSIndexPath*)currentTimeIndexPath
{
	NSDateFormatter *timeFormat = [[[NSDateFormatter alloc] init] autorelease];
	[timeFormat setDateFormat:@"HH:00"];
	int row = ([dates indexOfObject:[timeFormat stringFromDate:[NSDate date]]]+1)%24;
	return [NSIndexPath indexPathForRow:row inSection:0];
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

- (void)dealloc
{
	[dataSource release];
	[kal release];
	[super dealloc];
}

- (void)viewDidAppear:(BOOL)animated
{
	[kal.tableView selectRowAtIndexPath:dataSource.currentTimeIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self addViewInSliderWithClass:[ClassStackViewController class]];
}

- (void)addViewInSliderWithClass:(Class)aClass
{
	
	[kal.tableView cellForRowAtIndexPath:dataSource.currentTimeIndexPath].selected = YES;
	NSDateFormatter *dateFromat = [[[NSDateFormatter alloc] init] autorelease];
	[dateFromat setDateFormat:@"yyyy-MM-dd"];
	NSString *theDate = [dateFromat stringFromDate:kal.selectedDate];
	NSString *theTime = [dataSource.dates objectAtIndex:dataSource.currentTimeIndexPath.row];
	
	id dataViewController = [[aClass alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
	[[KobusReservationAppDelegate stackScrollViewController] addViewInSlider:dataViewController invokeByController:self isStackStartView:FALSE];
	[dataViewController release];
	
	id date = [NSString stringWithFormat:@"%@ %@",theDate,theTime];
	[self postNoticationReservation:@"KobusReservation" value:date key:@"date"];
	
	
	// 사이트 param 
	NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
	[df setDateFormat:@"yyyy"];
	NSString *dateYear = [df stringFromDate:kal.selectedDate];
	[df setDateFormat:@"MM"];
	NSString *dateMonth = [df stringFromDate:kal.selectedDate];
	[df setDateFormat:@"dd"];
	NSString *dateDay = [df stringFromDate:kal.selectedDate];
	
	[self postNoticationReservation:@"KobusReservation" value:dateYear key:@"Tim_date_Year"];
	[self postNoticationReservation:@"KobusReservation" value:dateMonth key:@"Tim_date_Month"];
	[self postNoticationReservation:@"KobusReservation" value:dateDay key:@"Tim_date_Day"];
	[self postNoticationReservation:@"KobusReservation" value:[theTime stringByReplacingOccurrencesOfString:@":" withString:@""] key:@"TIM_TIM_I"];
	
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


