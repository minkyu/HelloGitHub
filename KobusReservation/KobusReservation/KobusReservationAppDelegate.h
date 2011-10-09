//
//  KobusReservationAppDelegate.h
//  KobusReservation
//
//  Created by 오 화종 on 11. 09. 30.
//  Copyright 2011년 앱달. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwoPickerViewsController;

@interface KobusReservationAppDelegate : NSObject <UIApplicationDelegate> {
	TwoPickerViewsController *_twoPickerViewController;
}


@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@property (nonatomic, retain) IBOutlet TwoPickerViewsController *twoPickerViewController;


@end
