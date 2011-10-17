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
-(void) processData;
@property (nonatomic,copy) datas pushDatas;
@property (nonatomic,retain) NSString *responseString;
@property (nonatomic,retain) MutableSortedDictionary *Origins;
@property (nonatomic,retain) MutableSortedDictionary *Destinations;
- (SortedDictionary*)destinationForOrgine:(NSString*)fromCode;
- (void)loadWeb;
- (NSArray *) matchesOfOriginsInString:(NSString*)aString;
- (NSArray *) matchesOfDestinationsInString:(NSString*)aString;
- (void)loadOrigins;
- (void)loadDestinations;
- (void)parseOrigins:(NSString*)aStr;
- (void)parseDestinations:(NSString*)aStr;
- (void)failWithError:(NSError *)error;
@end
