//
//  KobusReservationAppDelegate.h
//  KobusReservation
//
//  Created by 오 화종 on 11. 09. 30.
//  Copyright 2011년 앱달. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackScrollViewController.h"

@class RootViewController;
@class KobusWeb;
@class KobusReservationQueryData;


@interface KobusReservationAppDelegate : NSObject <UIApplicationDelegate>


@property (nonatomic, retain) KobusWeb *web;
@property (nonatomic, retain) KobusReservationQueryData *reservationQueryData;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) RootViewController *rootViewController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (KobusReservationAppDelegate *) instance;
+ (StackScrollViewController *) stackScrollViewController;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (SortedDictionary*)originData;
- (SortedDictionary*)destinationData;

@end
