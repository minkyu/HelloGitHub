//
//  BusSeatSelectViewController.h
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 24..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusSeatSelectViewController : UIViewController
{
	int busClass;
}
@property (retain, nonatomic) IBOutlet UIView *PremiumClassView;
@property (retain, nonatomic) IBOutlet UIView *NormalClassView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil busClass:(int)aBusClass;
- (IBAction)buttonAction:(id)sender;

@end
