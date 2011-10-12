//
//  ClassStackViewController.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 12..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "ClassStackViewController.h"

const int padding = 10;

@implementation ClassStackViewController


- (void)addButton:(NSString*)title origin:(CGPoint)origin size:(CGSize)size tag:(int)aTag
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.tag = aTag;
	[button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:title forState:UIControlStateNormal];
	button.frame = CGRectMake(origin.x, 
							  origin.y, 
							  size.width, 
							  size.height);
	[self.view addSubview:button];
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self.titleLabel setText:@"  등급"];
		CGSize buttonsize = CGSizeMake(frame.size.width/3, frame.size.width/3);
		
		
		[self addButton:@"일반고속" 
				 origin:CGPointMake(padding,titleHeight+boundaryHeight+padding) 
				   size:buttonsize
					tag:1];
		
		[self addButton:@"우등고속"
				 origin:CGPointMake(padding+padding+buttonsize.width,titleHeight+boundaryHeight+padding) 
				   size:buttonsize
					tag:2];
		
		[self addButton:@"심야우등" 
				 origin:CGPointMake(padding,titleHeight+boundaryHeight+padding+buttonsize.height+padding) 
				   size:buttonsize
					tag:3];
		
		[self addButton:@"심야고속" 
				 origin:CGPointMake(padding+padding+buttonsize.width,titleHeight+boundaryHeight+padding+buttonsize.height+padding) 
				   size:buttonsize
					tag:4];
		
		
	}
	return self;
}

- (void)selectedButton:(UIButton*)button
{
	NSLog(@"tag:%d",button.tag);
}

@end
