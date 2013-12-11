//
//  TKCaseDropListCell.m
//  Eland
//
//  Created by aJia on 2013/12/11.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseDropListCell.h"
#import "NSString+TPCategory.h"
@implementation TKCaseDropListCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    
    _select = [[CVUISelect alloc] initWithFrame:CGRectZero];
	_select.popoverText.popoverTextField.borderStyle=UITextBorderStyleRoundedRect;
    _select.popoverText.popoverTextField.textAlignment = NSTextAlignmentLeft;
    _select.popoverText.popoverTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _select.popoverText.popoverTextField.font = [UIFont boldSystemFontOfSize:16.0];
    //_field.delegate=self;
	[self.contentView addSubview:_select];

    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect r=CGRectInset(self.bounds, 10, 4);
	[self.select setFrame:r];
}
#pragma mark public methods
-(BOOL)hasValue{
    NSString *str=[self.select.popoverText.popoverTextField.text Trim];
    if ([str length]>0) {
        return YES;
    }
    return NO;
}
@end
