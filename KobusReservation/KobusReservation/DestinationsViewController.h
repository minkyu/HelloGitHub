//
//  DetailViewController.h
//  KobusReservation
//
//  Created by 오 화종 on 11. 09. 30.
//  Copyright 2011년 앱달. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@class OriginsViewController;

@interface DestinationsViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) NSString *detailItem;

@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, assign) IBOutlet OriginsViewController *rootViewController;

@property (nonatomic, retain) NSDictionary *Destinations;

@property (nonatomic, retain) IBOutlet UITableView *destinationsView;

- (IBAction)insertNewObject:(id)sender;

@end
