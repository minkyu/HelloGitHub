//
//  DestinationsViewController.h
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
@property (nonatomic, assign) IBOutlet OriginsViewController *rootViewController;
@property (nonatomic, retain) IBOutlet UITableView *destinationsView;

@property (nonatomic, retain) NSString *selectedOrigin;
@property (nonatomic, retain) SortedDictionary *Destinations;

@end
