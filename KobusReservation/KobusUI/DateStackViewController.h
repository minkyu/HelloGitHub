//
//  DateStackViewController.h
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 11..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "DataTableViewController.h"
#import "Kal.h"

@class KalViewController;

@interface DateDataSource : SimpleKalDataSource 
@property (nonatomic,retain) NSArray *dates;

- (NSIndexPath*)currentTimeIndexPath;
@end

@interface DateStackViewController : DataViewController <UITableViewDelegate>

@property (nonatomic, retain) KalViewController *kal;
@property (nonatomic, retain) DateDataSource *dataSource;

@end


