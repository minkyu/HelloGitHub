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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil busClass:(int)aBusClass
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		busClass = aBusClass;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (busClass==NORMALCLASS) 
	{
		[self.view addSubview:NormalClassView];
	}
	else
	{
		[self.view addSubview:PremiumClassView];
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

- (IBAction)buttonAction:(id)sender 
{
	NSLog(@"%d",[sender tag]);
}
- (void)dealloc {
	[NormalClassView release];
	[PremiumClassView release];
	[super dealloc];
}
@end
