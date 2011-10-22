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

- (void)postNoticationReservation:(NSString*)name value:(NSString*)value key:(NSString*)key 
{
	[self postNoticationReservation:name value:value key:key object:nil];
}

- (void)postNoticationReservation:(NSString*)name object:(NSString*)object
{
	[self postNoticationReservation:name value:nil key:nil object:object];
}

- (void)postNoticationReservation:(NSString*)name value:(NSString*)value key:(NSString*)key object:(NSString*)object
{
	NSDictionary *uerinfo = [NSDictionary dictionaryWithObjectsAndKeys:
							 key,@"key",
							 value,@"value"
							 ,nil];	 
	NSLog(@"%@",uerinfo);
	[[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:uerinfo];
}

- (void)addButton:(NSString*)title origin:(CGPoint)origin size:(CGSize)size tag:(int)aTag
{
	UIButton *button = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	button.tag = aTag;
	[button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:title forState:UIControlStateNormal];
	button.frame = CGRectMake(origin.x, 
							  origin.y, 
							  size.width, 
							  size.height);
	[self.view addSubview:button];
	[button release];
}

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
		[boundaryView release];
		
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
