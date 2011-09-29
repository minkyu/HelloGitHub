//
//  DetailViewController.h
//  iPadProject
//
//  Created by 오 화종 on 11. 09. 24.
//  Copyright 2011년 앱달. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@class RootViewController;

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate>
{
	NSTimer *faceTimer;

	
	int winksLeft;
}


@property (nonatomic, retain) NSTimer *faceTimer;

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) NSManagedObject *detailItem;

@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, assign) IBOutlet RootViewController *rootViewController;

- (IBAction)insertNewObject:(id)sender;
- (IBAction)wakeUp:(id)sender;

@end
