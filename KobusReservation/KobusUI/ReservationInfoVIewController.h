//
//  ReservationInfoVIewController.h
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 22..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridTableViewController.h"
@class KobusReservationInfoList;

@interface ReservationInfoVIewController : GridTableViewController

@property(nonatomic,copy) KobusReservationInfoList *infolist;

- (id)initWithInfoList:(KobusReservationInfoList*)aInfoList;

@end
