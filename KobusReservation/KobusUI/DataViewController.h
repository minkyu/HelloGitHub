//
//  DataViewController.h
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 11..
//  Copyright 2011년 앱달. All rights reserved.
//

#import <UIKit/UIKit.h>

#define titleHeight		60
#define boundaryHeight	5

@interface DataViewController : UIViewController

@property(nonatomic, retain)UILabel* titleLabel;

- (id)initWithFrame:(CGRect)frame;
- (void)addButton:(NSString*)title origin:(CGPoint)origin size:(CGSize)size tag:(int)aTag;
- (void)postNoticationReservation:(NSString*)name value:(NSString*)value key:(NSString*)key;
@end
