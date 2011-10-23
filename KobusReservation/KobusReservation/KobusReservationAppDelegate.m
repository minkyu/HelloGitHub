//
//  KobusReservationAppDelegate.m
//  KobusReservation
//
//  Created by 오 화종 on 11. 09. 30.
//  Copyright 2011년 앱달. All rights reserved.
//

#import "KobusReservationAppDelegate.h"
#import "RootViewController.h"
#import "KobusWeb.h"
#import "KobusReservationQueryData.h"
#import "ReservationInfoVIewController.h"

@implementation KobusReservationAppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize rootViewController = _rootViewController;
@synthesize web,reservationQueryData;

+ (KobusReservationAppDelegate *) instance {
	return (KobusReservationAppDelegate *) [[UIApplication sharedApplication] delegate];
}

+ (StackScrollViewController *) stackScrollViewController
{
	return [[[KobusReservationAppDelegate instance] rootViewController] stackScrollViewController];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	web = [[KobusWeb alloc] init];
	[web loadKoBusWeb];
	reservationQueryData = [[KobusReservationQueryData alloc] init];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KobusReservationObjectNoti:) name:@"KobusReservation" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReservationInfoQuery:) name:@"ReservationInfoQuery" object:nil];
	
	_rootViewController = [[RootViewController alloc] init];
	[self.window setBackgroundColor:[UIColor clearColor]];
    [self.window addSubview:_rootViewController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)KobusReservationObjectNoti:(NSNotification*)noti
{
	NSDictionary *notiDic = [noti userInfo];
	
	NSString *key = [notiDic objectForKey:@"key"];
	NSString *value = [notiDic objectForKey:@"value"];
	
	[reservationQueryData setValue:value forKey:key];
	
	
}

- (void)showReservationInfoList:(KobusReservationInfoList*)aInfolist;
{
	ReservationInfoVIewController *viewcon = [[ReservationInfoVIewController alloc] initWithInfoList:aInfolist];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewcon];
	[viewcon release];
	navController.modalPresentationStyle = UIModalPresentationFormSheet;
	navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[_rootViewController presentModalViewController:navController animated:YES];
	[navController release];
}


// 예약 가능한 버스 시간, 좌석 수 등을 조회
- (void)ReservationInfoQuery:(NSNotification*)noti
{
	if ([[noti object] isEqualToString:@"doReservation"]) {

		NSString *check = [reservationQueryData checkValidation];
		if ([check isEqualToString:@"OK"]) {

			[web sendReservationInfoQueryString:[reservationQueryData toGETParamString] withInfoList:^(KobusReservationInfoList *infolist) 
			{
				[self showReservationInfoList:infolist];
			}];			
		}
		else
		{
			NSLog(@"으아니! %@",check);
		}
		
		
	}
}


// 출발지 목록
- (SortedDictionary*)originData
{
	return web.Origins;
}


// 도착지 목록
- (SortedDictionary*)destinationData
{
	return web.Destinations;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Saves changes in the application's managed object context before the application terminates.
	[self saveContext];
}

- (void)dealloc
{
	[_window release];
	[__managedObjectContext release];
	[__managedObjectModel release];
	[__persistentStoreCoordinator release];
	[_rootViewController release];
    [super dealloc];
}

- (void)awakeFromNib
{
    // Pass the managed object context to the root view controller.
    
}
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"KobusReservation" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"KobusReservation.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
