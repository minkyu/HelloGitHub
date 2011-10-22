/*
 This module is licenced under the BSD license.
 
 Copyright (C) 2011 by raw engineering <nikhil.jain (at) raweng (dot) com, reefaq.mohammed (at) raweng (dot) com>.
 
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
//
//  MenuViewController.m
//  StackScrollView
//
//  Created by Reefaq on 2/24/11.
//  Copyright 2011 raw engineering . All rights reserved.
//

#import "MenuViewController.h"
#import "KobusReservationAppDelegate.h"
#import "StackViewController.h"


@implementation MenuViewController
@synthesize tableView = _tableView;


#pragma mark -
#pragma mark View lifecycle

- (id)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
		
		[self.view setFrame:frame]; 
		
		_menus = [[NSArray arrayWithObjects:@"조회하기", @"즐겨찾기",nil] retain];
		
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2) style:UITableViewStylePlain];
		[_tableView setDelegate:self];
		[_tableView setDataSource:self];
		[_tableView setBackgroundColor:[UIColor clearColor]];
		_tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
		[_tableView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
		[self.view addSubview:_tableView];
	
		[self addKobusReservationInfoView];
		
		
		UIView* verticalLineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, -5, 1, self.view.frame.size.height)];
		[verticalLineView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
		[verticalLineView setBackgroundColor:[UIColor whiteColor]];
		[self.view addSubview:verticalLineView];
		[self.view bringSubviewToFront:verticalLineView];	
		
	}
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)addKobusReservationInfoView
{
	_kobusReservationInfo = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2)];

	[_kobusReservationInfo setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	[self.view addSubview:_kobusReservationInfo];

	NSArray *labelarray = [NSArray arrayWithObjects:@"출발",@"도착",@"년도",@"월",@"일",@"시간",@"등급",@"어른",@"아동", nil];
	CGSize infoViewSize =  _kobusReservationInfo.frame.size;
	
	for (int i =0; i<[labelarray count]; i++) 
	{
		NSString *name = [labelarray objectAtIndex:i];
		CGRect labelframe = CGRectMake(0, (int)(infoViewSize.height/[labelarray count])*i, 
									   infoViewSize.width/6.f, (int)(infoViewSize.height/[labelarray count]));
		UILabel *infoName = [[UILabel alloc] initWithFrame:labelframe];
		[infoName setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
		[infoName setText:name];
		[infoName setTextAlignment:UITextAlignmentCenter];
		[infoName setBackgroundColor:[UIColor clearColor]];
		infoName.layer.borderColor = [UIColor blackColor].CGColor; //테두리 색상
		infoName.layer.borderWidth = 1.0; //테두리 두께
		[_kobusReservationInfo addSubview:infoName];
	}
	
	NSArray *hashlabelarray = [NSArray arrayWithObjects:@"origin",@"destination",@"Tim_date_Year",@"Tim_date_Month",@"Tim_date_Day",@"TIM_TIM_I",@"busClass",@"pCnt_100",@"pCnt_050", nil];
	for (int i =0; i<[hashlabelarray count]; i++) 
	{
		NSString *name = [hashlabelarray objectAtIndex:i];
		CGRect labelframe = CGRectMake(infoViewSize.width/6.f, (int)(infoViewSize.height/[labelarray count])*i, 
									   (infoViewSize.width/6.f)*5, (int)(infoViewSize.height/[labelarray count]));
		UILabel *hashlabel = [[UILabel alloc] initWithFrame:labelframe];
		[hashlabel setTag:[name hash]];
		[hashlabel setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
		[hashlabel setBackgroundColor:[UIColor clearColor]];
		hashlabel.layer.borderColor = [UIColor blackColor].CGColor; //테두리 색상
		hashlabel.layer.borderWidth = 1.0; //테두리 두께
		[_kobusReservationInfo addSubview:hashlabel];
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reservationInfo:) name:@"KobusReservation" object:nil];
	
}

- (void)reservationInfo:(NSNotification*)noti
{
	NSDictionary* notiDic =[noti userInfo];
	NSString *key = [notiDic objectForKey:@"key"];
	NSString *value = [notiDic objectForKey:@"value"];
	
	UILabel *label = (UILabel*)[_kobusReservationInfo viewWithTag:[key hash]];
	[label setText:value];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_menus count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		UIView* bgView = [[[UIView alloc] init] autorelease];
		[bgView setBackgroundColor:[UIColor colorWithWhite:2 alpha:0.2]];
		[cell setSelectedBackgroundView:bgView];
    }
    
    // Configure the cell...
	cell.textLabel.text = [_menus objectAtIndex:indexPath.row];
	[cell.textLabel setTextColor:[UIColor whiteColor]];


    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	OriginsStackViewController *dataViewController = [[OriginsStackViewController alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
	[[KobusReservationAppDelegate stackScrollViewController] addViewInSlider:dataViewController invokeByController:self isStackStartView:TRUE];
//	TicketCountStackViewController *dataViewController = [[TicketCountStackViewController alloc] initWithFrame:CGRectMake(0, 0, 477, self.view.frame.size.height)];
//	[[KobusReservationAppDelegate stackScrollViewController] addViewInSlider:dataViewController invokeByController:self isStackStartView:TRUE];

}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
	[_menus release];
	self.tableView = nil;
    [super dealloc];
}


@end

