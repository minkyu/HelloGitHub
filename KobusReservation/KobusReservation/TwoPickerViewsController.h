//
//  TwoPickerViewsController.h
//  KobusReservation
//
//  Created by 오 화종 on 11. 10. 09.
//  Copyright 2011년 앱달. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KobusWeb;
@interface TwoPickerViewsController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
	BOOL originSelected;
	id selectedOrigin;
	id selectedDestination;
	IBOutlet UIPickerView *queryPicker;
}

@property(nonatomic, retain) KobusWeb *model;
@end
