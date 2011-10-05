//
//  RootViewController.h
//  KobusReservation
//
//  Created by 오 화종 on 11. 09. 30.
//  Copyright 2011년 앱달. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DestinationsViewController;


@interface OriginsViewController : UITableViewController 

@property (nonatomic, retain) IBOutlet DestinationsViewController *detailViewController;

@property (nonatomic, retain) NSDictionary *Origins;

- (void)insertNewObject:(id)sender;

@end
