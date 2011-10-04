//
//  KobusWeb.h
//  KobusReservation
//
//  Created by kim hongjun on 11. 9. 30..
//  Copyright 2011년 앱달. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KobusWeb : NSObject 
{
	NSMutableData *responseData;
	NSMutableDictionary *Origins;
	NSMutableDictionary *Destinations;
}

@property (nonatomic,retain) NSMutableData *responseData;
@property (nonatomic,retain) NSMutableDictionary *Origins;
@property (nonatomic,retain) NSMutableDictionary *Destinations;

- (void)loadWeb;
- (NSArray *) matchesOfOriginsInString:(NSString*)aString;
- (NSArray *) matchesOfDestinationsInString:(NSString*)aString;
- (void)loadOrigins;
- (void)loadDestinations;
- (NSString*)webDataEncoding;
- (void)parseOrigins:(NSString*)aStr;
- (void)parseDestinations:(NSString*)aStr;
@end
