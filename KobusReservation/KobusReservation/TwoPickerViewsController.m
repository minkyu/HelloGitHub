//
//  TwoPickerViewsController.m
//  KobusReservation
//
//  Created by 오 화종 on 11. 10. 09.
//  Copyright 2011년 앱달. All rights reserved.
//

#import "TwoPickerViewsController.h"
#import "KobusWeb.h"

@implementation TwoPickerViewsController
@synthesize model;

-(void) dealloc
{
	[queryPicker release];
	self.model = nil;
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		originSelected = false;
		selectedOrigin = nil;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modelHasCompletedHtmlParsing:) name:@"html분석이 끝났다." object:nil];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self){
        // Custom initialization
		originSelected = false;
		selectedOrigin = nil;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modelHasCompletedHtmlParsing:) name:@"html분석이 끝났다." object:nil];		
	}
	return self;
}

-(void) modelHasCompletedHtmlParsing:(NSNotification*)noti
{
	[queryPicker reloadAllComponents];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(BOOL) originSelected
{
	return selectedOrigin != nil;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return [self originSelected]?2:1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if(component==0) return [[model.Origins allKeys] count];
	if(component==1) return [[[model.Destinations objectForKey: selectedOrigin] allValues] count];
	return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if(component==0) {
		selectedOrigin = [[model.Origins allKeys] objectAtIndex: row];
	}
	if(component==1){
		selectedDestination = [[[model.Destinations objectForKey: selectedOrigin] allValues] objectAtIndex: row];
	}
	[queryPicker reloadAllComponents];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if(component==0) return [[model.Origins allValues] objectAtIndex:row];
	if(component==1) return [[[model.Destinations objectForKey: selectedOrigin] allValues] objectAtIndex:row];
	return @"error";
}

@end
