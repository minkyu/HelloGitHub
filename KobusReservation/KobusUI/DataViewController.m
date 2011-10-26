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

- (void)addViewInSliderWithClass:(Class)aClass
{
	[NSException raise:@"addViewInSlider 구현해주세요" format:@"%@", self];
}

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
	[[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:uerinfo];


}

- (void)addButton:(NSString*)title origin:(CGPoint)origin size:(CGSize)size tag:(int)aTag Autoresizing:(UIViewAutoresizing)Autoresizing
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.tag = aTag;
	[button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:title forState:UIControlStateNormal];
	button.frame = CGRectMake(origin.x, 
							  origin.y, 
							  size.width, 
							  size.height);
	button.autoresizingMask = Autoresizing;
	[self.view addSubview:button];
}

- (void)addButton:(NSString*)title origin:(CGPoint)origin size:(CGSize)size tag:(int)aTag
{
	[self addButton:title origin:origin size:size tag:aTag Autoresizing:UIViewAutoresizingNone];
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}

@end
