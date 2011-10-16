//
//  TicketCountStackViewController.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 12..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "TicketCountStackViewController.h"
#import "SVSegmentedControl.h"

static const int labelHeight = 40;
static const int padding = 10;
static const int adultTag = 100;
static const int childrenTag = 200;

@implementation TicketCountStackViewController

@synthesize childrenStr,adultStr;
@synthesize adultTicketCnt, childTicketCnt;

- (float)addSVSegmentedControl:(NSArray*)array originY:(float)originY frameWidth:(float)frameWidth tag:(int)tag;  
{
	SVSegmentedControl *RC = [[SVSegmentedControl alloc] initWithSectionTitles:array];
	[RC addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
	RC.tag = tag;
	
	RC.crossFadeLabelsOnDrag = YES;
	RC.font = [UIFont fontWithName:@"Marker Felt" size:20];
	RC.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 14);
	RC.height = 40;
	RC.selectedIndex = 0;
	
	RC.thumb.tintColor = [UIColor colorWithRed:0.999 green:0.889 blue:0.312 alpha:1.000];
	RC.thumb.textColor = [UIColor blackColor];
	RC.thumb.shadowColor = [UIColor colorWithWhite:1 alpha:0.5];
	RC.thumb.shadowOffset = CGSizeMake(0, 1);
	
	UIScrollView *scrollView = [[UIScrollView alloc] init];	
	[scrollView setBackgroundColor:[UIColor colorWithHue:0.f saturation:0.f brightness:0.3f alpha:1.f]];
	[scrollView setBounces:NO];
	[self.view addSubview:scrollView];	
	[scrollView addSubview:RC];
	
	[scrollView setFrame:CGRectMake(0, originY,frameWidth , RC.frame.size.height)];
	[scrollView setContentSize:CGSizeMake(RC.frame.size.width, RC.frame.size.height)];
	RC.center = CGPointMake(scrollView.contentSize.width/2, scrollView.frame.size.height/2);
	
	[scrollView release];
	[RC release];
	return scrollView.frame.size.height;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self.titleLabel setText:@"  매수"];
		
		UILabel *adult = [[UILabel alloc] initWithFrame:CGRectMake(0,titleHeight+boundaryHeight , frame.size.width, labelHeight)];
		[adult setText:@"어른"];
		[self.view addSubview:adult];
		[adult release];
		
		
		
		NSMutableArray *array = [NSMutableArray array];
		for (int i = 0; i <= 40; i++) 
		{
			[array addObject:[NSString stringWithFormat:@"%d",i]];
		}
		float adultSegmentHeight = [self addSVSegmentedControl:array 
													   originY:titleHeight+boundaryHeight+labelHeight 
													frameWidth:frame.size.width 
														   tag:adultTag];
		
		UILabel *children = [[UILabel alloc] initWithFrame:CGRectMake(0,titleHeight+boundaryHeight+labelHeight+adultSegmentHeight , frame.size.width, 40)];
		[children setText:@"아동"];
		[self.view addSubview:children];
		[children release];
		
		float childrenSegmentHeight = [self addSVSegmentedControl:array 
														  originY:titleHeight+boundaryHeight+labelHeight*2+adultSegmentHeight 
													   frameWidth:frame.size.width
															  tag:childrenTag];
		
		CGPoint bouttonpoint = CGPointMake(padding, 
										   titleHeight+boundaryHeight+labelHeight*2+adultSegmentHeight+childrenSegmentHeight+padding );
		CGSize buttionsize = CGSizeMake(frame.size.width-padding*2, 
										frame.size.height-(titleHeight+boundaryHeight+labelHeight*2+adultSegmentHeight+childrenSegmentHeight+padding*2));
		[self addButton:@"예약하기" origin:bouttonpoint size:buttionsize tag:10];
		
	
	}
	return self;
}

- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl 
{
	NSLog(@"segmentedControl %i did select index %i (via UIControl method)", segmentedControl.tag, segmentedControl.selectedIndex);
	
	if (segmentedControl.tag == adultTag) {
		self.adultStr = [NSString stringWithFormat:@"어른:%d",segmentedControl.selectedIndex];
		self.adultTicketCnt = [[NSNumber numberWithInteger:segmentedControl.selectedIndex] stringValue];
		
	} else {
		self.childrenStr = [NSString stringWithFormat:@"아동:%d",segmentedControl.selectedIndex]; 
		self.childTicketCnt = [[NSNumber numberWithInteger:segmentedControl.selectedIndex] stringValue];
	}
	
}

- (void)selectedButton:(UIButton*)button
{
	
	NSString *TicketCount = [NSString stringWithFormat:@"%@  %@",adultStr,childrenStr]; 
	[self postNoticationReservation:@"KobusReservation" value:TicketCount key:@"ticketCount"];
	
	// 사이트 param
	[self postNoticationReservation:@"KorbusReservation" value:adultTicketCnt key:@"pCnt_100"];
	[self postNoticationReservation:@"KorbusReservation" value:childTicketCnt key:@"pCnt_050"];
	
	// TODO 값 Validation 로직 
	// TODO 예약 값을 사이트로 전송한 후 페이지를 받아옴
	// TODO 자리 선택하는 View 생성

}

- (void)doReservation
{
	NSURL *url = [NSURL URLWithString:@"http://m.kobus.co.kr/web/m/reservation/sch_bus.jsp"];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	
	
//	[request setPostValue:@"Ben" forKey:@"first_name"];
//	[request setPostValue:@"Copsey" forKey:@"last_name"];
//	[request setFile:@"/Users/ben/Desktop/ben.jpg" forKey:@"photo"];
//	
	
	
}

@end
