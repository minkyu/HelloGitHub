//
//  ReservationInfoVIewController.m
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 22..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import "ReservationInfoVIewController.h"
#import "KobusReservationInfoList.h"

@implementation ReservationInfoVIewController
@synthesize infolist;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
												   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
												   target:self
												   action:@selector(dismissView:)] autorelease];
		
		
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
	[recognizer setNumberOfTapsRequired:1];
	recognizer.cancelsTouchesInView = NO; //So the user can still interact with controls in the modal view
	[self.view.window addGestureRecognizer:recognizer];
	[recognizer release];
	
	NSLog(@"%@",infolist.infoList);
	NSLog(@"%@",[infolist getTypeStringAtIndex:0]);
}

- (void)handleTapBehind:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
	{
		CGPoint location = [sender locationInView:nil]; //Passing nil gives us coordinates in the window
		
		//Then we convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.
		
        if (![self.view pointInside:[self.view convertPoint:location fromView:self.view.window] withEvent:nil]) 
        {
			
			[sender removeTarget:self action:@selector(handleTapBehind:)];
			[self.view.window removeGestureRecognizer:sender];
			[self dismissModalViewControllerAnimated:YES];
			NSLog(@"handleTapBehind recognizer = %@",sender);
        }
	}
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)dismissView:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
