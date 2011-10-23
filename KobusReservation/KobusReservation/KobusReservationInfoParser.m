//
//  KobusReservationInfoParser.m
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 24..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import "KobusReservationInfoParser.h"

#define TimeTagIndex 1
#define ClassTagIndex 2
#define CompanyTagIndex 3
#define TicketCountTagIndex 4


@implementation KobusReservationInfoParser

+ (KobusReservationInfoList*)parsing:(NSData*)responseData
{
	TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:responseData];
	KobusReservationInfoList *infolist = [[KobusReservationInfoList alloc] init];
	int seatformcount = 0;
	while (42) {
		//<form name="SeatForm
		TFHppleElement *seatForm = [hpple peekAtSearchWithXPathQuery:[NSString stringWithFormat:@"//form[@name='SeatForm%d']",seatformcount++]];
		if (!seatForm) {
			break;
		}
		//<tr ... table row
		TFHppleElement *tr = [seatForm firstChild];
		//<td ... table data
		NSArray *tds = [tr children];
		NSMutableArray *info = [NSMutableArray new];
		[info addObject:[[tds objectAtIndex:TimeTagIndex] content]];
		[info addObject:[[tds objectAtIndex:ClassTagIndex] content]];
		[info addObject:[[tds objectAtIndex:CompanyTagIndex] content]];
		[info addObject:[[tds objectAtIndex:TicketCountTagIndex] content]];
		[infolist addInfoList:info];
		
		NSMutableDictionary	*hideinfo = [NSMutableDictionary new];
		for (int i = TicketCountTagIndex+1; i<[tds count]; i++) {
			if ([[[tds objectAtIndex:i] tagName] isEqualToString:@"input"]) {
				[hideinfo setValue:[[tds objectAtIndex:i] objectForKey:@"value"] forKey:[[tds objectAtIndex:i] objectForKey:@"name"]];
			}
		}
		[infolist addHideInfoList:hideinfo];
		
	}
	[hpple release];
	return infolist;
}


@end
