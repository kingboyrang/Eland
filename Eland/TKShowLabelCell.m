//
//  TKShowLabelCell.m
//  Eland
//
//  Created by aJia on 13/10/14.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKShowLabelCell.h"
#import "NSString+TPCategory.h"
#import "UIColor+TPCategory.h"
@implementation TKShowLabelCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
	_label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentRight;
    _label.textColor = [UIColor colorFromHexRGB:@"3DB5C0"];
    _label.font = [UIFont boldSystemFontOfSize:16.0];
    _label.adjustsFontSizeToFitWidth = YES;
    _label.baselineAdjustment = UIBaselineAdjustmentNone;
    _label.numberOfLines = 20;
	[self.contentView addSubview:_label];
    
    
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGSize size=[_label.text textSize:[UIFont boldSystemFontOfSize:16.0] withWidth:self.bounds.size.width];
    CGRect r = CGRectInset(self.contentView.bounds, 8, 8);
    r.size = size;
	_label.frame = r;
	/***
    CGSize optimumSize = [self.label optimumSize];
	CGRect frame = [self.label frame];
	frame.size.height = (int)optimumSize.height + 5;
    frame.origin.y=(self.bounds.size.height-frame.size.height)/2.0;
	[self.label setFrame:frame];
     ***/
    
}
@end
