//
//  DataViewController.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 11..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "DataViewController.h"

@implementation DataViewController


@synthesize titleLabel = _titleLabel;

#pragma mark -
#pragma mark View lifecycle

- (id)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
		[self.view setFrame:frame]; 
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width , titleHeight)];
		[_titleLabel setFont:[UIFont systemFontOfSize:30]];
		
		UIView *boundaryView = [[UIView alloc] initWithFrame:CGRectMake(0, titleHeight, self.view.frame.size.width, boundaryHeight)];
		[boundaryView setBackgroundColor:[UIColor redColor]];
		[self.view addSubview:_titleLabel];
		[self.view addSubview:boundaryView];
		[self.view setBackgroundColor:[UIColor whiteColor]];
		
	}
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}

@end
