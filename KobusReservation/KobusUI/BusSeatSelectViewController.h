//
//  BusSeatSelectViewController.h
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 24..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusSeatSelectViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIView *PremiumClassView;
@property (retain, nonatomic) IBOutlet UIView *NormalClassView;
@property (retain, nonatomic) NSDictionary *busInfo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil busInfo:(NSDictionary*)abusInfo;
- (IBAction)buttonAction:(id)sender;

@end
