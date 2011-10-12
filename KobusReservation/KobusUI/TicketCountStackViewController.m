//
//  TicketCountStackViewController.m
//  KobusReservation
//
//  Created by kim hongjun on 11. 10. 12..
//  Copyright 2011년 앱달. All rights reserved.
//

#import "TicketCountStackViewController.h"


@implementation TicketCountStackViewController

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self.titleLabel setText:@"  매수"];
		
		CGRect pickerViewFrame = frame;
		pickerViewFrame.origin.y = titleHeight+boundaryHeight;
		pickerViewFrame.size.height = 216;
		UIScrollView *pickerBackGraundView = [[UIScrollView alloc] initWithFrame:pickerViewFrame];
		pickerBackGraundView.userInteractionEnabled = YES;
		[self.view addSubview:pickerBackGraundView];
		
		pickerViewFrame.origin.y = 0;
		UIPickerView *ticketPickerView = [[UIPickerView alloc] initWithFrame:pickerViewFrame];
		ticketPickerView.showsSelectionIndicator= YES;
		ticketPickerView.userInteractionEnabled	= YES;
		ticketPickerView.delegate = self;
		ticketPickerView.dataSource = self;
		[pickerBackGraundView addSubview:ticketPickerView];
		
		CGPoint bouttonpoint = CGPointMake(0, 216+titleHeight+boundaryHeight+10);
		CGSize buttionsize = CGSizeMake(frame.size.width, frame.size.height-(216+titleHeight+boundaryHeight+10));
		[self addButton:@"에약하기" origin:bouttonpoint size:buttionsize tag:10];
		
	}
	return self;
}

- (void)selectedButton:(UIButton*)button
{
	NSLog(@"%d",button.tag);
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return 10;
}

#pragma makr - UIPickerViewDelegate


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [NSString stringWithFormat:@"%d",row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSLog(@"%d %d",row,component);
}

@end
