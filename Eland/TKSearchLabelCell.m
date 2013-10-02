//
//  TKSearchLabelCell.m
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKSearchLabelCell.h"
#import "UIColor+TPCategory.h"
#import "NSString+TPCategory.h"
@implementation TKSearchLabelCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
	_label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentRight;
    _label.textColor = [UIColor colorFromHexRGB:@"3db5c0"];
    _label.font = [UIFont boldSystemFontOfSize:16.0];
	[self.contentView addSubview:_label];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    CGSize size=[_label.text textSize:[UIFont boldSystemFontOfSize:16.0] withWidth:self.frame.size.width];
	CGRect frame = [self.label frame];
	frame.size=size;
    frame.origin.y=(self.bounds.size.height-frame.size.height)/2.0;
    frame.origin.x=10;
	[self.label setFrame:frame];
    
}
@end
