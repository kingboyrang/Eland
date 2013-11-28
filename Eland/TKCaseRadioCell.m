//
//  TKCaseRadioCell.m
//  Eland
//
//  Created by aJia on 2013/11/28.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseRadioCell.h"

@implementation TKCaseRadioCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _radioView = [[ChooseRadioView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
       
    [self.contentView addSubview:_radioView];
    //    UIView *tempView = [[[UIView alloc] init] autorelease];
    //    [self setBackgroundView:tempView];
    //    [self setBackgroundColor:[UIColor clearColor]];
    
    return self;
}

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
-(void)setSelectedItemText:(NSString*)txt{
    if (txt&&([txt isEqualToString:@"1"]||[txt isEqualToString:@"是"])) {
        [_radioView setSelectedIndex:1];
        return;
    }
    [_radioView setSelectedIndex:2];
}
#pragma mark public methods
-(BOOL)hasValue{
    return YES;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect r=_radioView.frame;
    r.origin.y=(self.frame.size.height-r.size.height)/2;
    _radioView.frame=r;
}@end
