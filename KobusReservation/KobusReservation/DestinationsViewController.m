//
//  DetailViewController.m
//  KobusReservation
//
//  Created by 오 화종 on 11. 09. 30.
//  Copyright 2011년 앱달. All rights reserved.
//

#import "DestinationsViewController.h"

#import "OriginsViewController.h"

@implementation DestinationsViewController

@synthesize toolbar = _toolbar;
@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize rootViewController = _rootViewController;
@synthesize Destinations;
@synthesize destinationsView;

#pragma mark - Managing the detail item

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setDetailItem:(NSString *)seletedObject
{
	if (_detailItem != seletedObject) {
		[_detailItem release];
		_detailItem = [seletedObject retain];
		
		[destinationsView reloadData];
	}
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // Update the user interface for the detail item.

	// Normally should use accessor method, but using KVC here avoids adding a custom class to the template.
	cell.textLabel.text = [[[Destinations objectForKey:_detailItem] allValues] objectAtIndex:[indexPath row]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Destinations table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[Destinations objectForKey:_detailItem] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - Split view support

//- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController: (UIPopoverController *)pc
//{
//    barButtonItem.title = @"Events";
//    NSMutableArray *items = [[self.toolbar items] mutableCopy];
//    [items insertObject:barButtonItem atIndex:0];
//    [self.toolbar setItems:items animated:YES];
//    [items release];
//    self.popoverController = pc;
//}
//
//// Called when the view is shown again in the split view, invalidating the button and popover controller.
//- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
//{
//    NSMutableArray *items = [[self.toolbar items] mutableCopy];
//    [items removeObjectAtIndex:0];
//    [self.toolbar setItems:items animated:YES];
//    [items release];
//    self.popoverController = nil;
//}

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
 */

- (void)viewDidUnload
{
	[super viewDidUnload];

	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
	[_toolbar release];
	[_detailItem release];
	[_detailDescriptionLabel release];
    [super dealloc];
}

#pragma mark - Object insertion

- (IBAction)insertNewObject:(id)sender
{
	[self.rootViewController insertNewObject:sender];	
}

@end
