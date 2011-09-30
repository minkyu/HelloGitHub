//
//  KobusWeb.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 9. 30..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "KobusWeb.h"

#define EucKrEncoding 0x80000940

@implementation KobusWeb

@synthesize responseData,Origins,Destinations;

- (id)init
{
    self = [super init];
    if (self) 
	{

    }
    
    return self;
}

- (void)dealloc
{
	[responseData release];
	[Origins release];
	[Destinations release];
	[super dealloc];
}



- (void)loadWeb
{
	self.responseData = [[NSMutableData alloc] init];
	
	NSURLRequest *request =
	[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://kobus.co.kr/web/index.jsp"]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)loadOrigins
{
	self.Origins = [[NSMutableDictionary alloc]init];
	//responseData
	
}

- (void)loadDestinations
{
	self.Destinations = [[NSMutableDictionary alloc]init];
	//responseData
}

#pragma - NSURLConnection deletage

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSString * errorString = [NSString stringWithFormat:@"Error code %i", [error code]];
	
    UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString *webstring = [[NSString alloc] initWithData:responseData encoding:EucKrEncoding];
//	NSString *webstring = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSLog(@"%@",webstring);
	[connection release];
	
	[self loadOrigins];
}

@end
