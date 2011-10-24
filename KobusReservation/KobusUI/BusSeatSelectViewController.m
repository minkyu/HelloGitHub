//
//  BusSeatSelectViewController.m
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 24..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import "BusSeatSelectViewController.h"

#define NORMALCLASS 45
#define PREMIUMCLASS 28

@implementation BusSeatSelectViewController
@synthesize PremiumClassView;
@synthesize NormalClassView;
@synthesize busInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil busInfo:(NSDictionary*)abusInfo
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.busInfo = abusInfo;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)setSeat:(UIView*)view
{
	NSString* busSeatStateArrayStr = [busInfo objectForKey:@"pSet_sta"];
	NSRange seatpos = NSMakeRange(0, 1);
	for (int i = 0; i<[busSeatStateArrayStr length]; i++) {
		seatpos.location = i;
		if([[busSeatStateArrayStr substringWithRange:seatpos] intValue])
		{
			id button = [view viewWithTag:i+1];
			if ([button isKindOfClass:[UIButton class]]) {
				[button setEnabled:NO];
				[button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
			}
			
		}
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[busInfo objectForKey:@"pWeb_cnt"] intValue]==NORMALCLASS) 
	{
		[self.view addSubview:NormalClassView];
		[self setSeat:NormalClassView];
	}
	else
	{
		[self.view addSubview:PremiumClassView];
		[self setSeat:PremiumClassView];
	}
}

- (void)viewDidUnload
{
	[self setNormalClassView:nil];
	[self setPremiumClassView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)highlightButton:(UIButton *)b 
{ 
    [b setSelected:!b.selected];
	[b setHighlighted:b.selected];
}


- (IBAction)buttonAction:(id)sender 
{
	NSLog(@"%d",[sender tag]);
	[self performSelector:@selector(highlightButton:) withObject:sender afterDelay:0.0];
	
}
- (void)dealloc {
	[NormalClassView release];
	[PremiumClassView release];
	[super dealloc];
}
@end
