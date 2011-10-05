//
//  KobusWeb.h
//  KobusReservation
//
//  Created by kim hongjun on 11. 9. 30..
//  Copyright 2011년 앱달. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^datas)(SortedDictionary*,SortedDictionary*);


@interface KobusWeb : NSObject 

@property (nonatomic,copy) datas pushDatas;
@property (nonatomic,retain) NSMutableData *responseData;
@property (nonatomic,retain) MutableSortedDictionary *Origins;
@property (nonatomic,retain) MutableSortedDictionary *Destinations;

- (void)loadWeb;
- (NSArray *) matchesOfOriginsInString:(NSString*)aString;
- (NSArray *) matchesOfDestinationsInString:(NSString*)aString;
- (void)loadOrigins;
- (void)loadDestinations;
- (NSString*)webDataEncoding;
- (void)parseOrigins:(NSString*)aStr;
- (void)parseDestinations:(NSString*)aStr;
@end
