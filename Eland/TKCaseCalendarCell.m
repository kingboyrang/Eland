//
//  TKCaseCalendarCell.m
//  Eland
//
//  Created by aJia on 2013/11/27.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseCalendarCell.h"
#import "NSString+TPCategory.h"
@implementation TKCaseCalendarCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
   
    _lostCalendar = [[CVUICalendar alloc] initWithFrame:CGRectZero];
    _lostCalendar.popoverText.popoverTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _lostCalendar.popoverText.popoverTextField.borderStyle=UITextBorderStyleRoundedRect;
    _lostCalendar.popoverText.popoverTextField.font = [UIFont boldSystemFontOfSize:16.0];
    _lostCalendar.datePicker.maximumDate=[NSDate date];

    [self.contentView addSubview:_lostCalendar];
//    UIView *tempView = [[[UIView alloc] init] autorelease];
//    [self setBackgroundView:tempView];
//    [self setBackgroundColor:[UIColor clearColor]];
    
    return self;
}

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
#pragma mark public methods
-(BOOL)hasValue{
    NSString *str=[self.lostCalendar.popoverText.popoverTextField.text Trim];
    if ([str length]>0) {
        return YES;
    }
    return NO;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect r=CGRectInset(self.bounds, 10, 4);
    _lostCalendar.frame=r;
}
@end
