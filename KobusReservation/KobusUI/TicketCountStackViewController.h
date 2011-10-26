//
//  TicketCountStackViewController.h
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 12..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "DataViewController.h"
#import "ASIFormDataRequest.h"

#define adultTag  100
#define childrenTag 200


@interface TicketCountStackViewController : DataViewController 

@property (nonatomic,retain) NSString *childrenStr;
@property (nonatomic,retain) NSString *adultStr;

@property (nonatomic, retain) NSString *adultTicketCnt;
@property (nonatomic, retain) NSString *childTicketCnt;
- (void)selectTicket:(int)tag index:(int)index;
@end
