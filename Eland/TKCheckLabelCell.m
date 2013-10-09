//
//  TKCheckLabelCell.m
//  Eland
//
//  Created by aJia on 13/10/9.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCheckLabelCell.h"
#import "NSString+TPCategory.h"
#import "UIColor+TPCategory.h"
@implementation TKCheckLabelCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
        
    _leftLabel=[[UILabel alloc] initWithFrame:CGRectZero];
    _leftLabel.font=[UIFont boldSystemFontOfSize:16];
    _leftLabel.textColor=[UIColor colorFromHexRGB:@"666666"];
    _leftLabel.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:_leftLabel];
    
    _rightLabel=[[UILabel alloc] initWithFrame:CGRectZero];
    _rightLabel.font=[UIFont boldSystemFontOfSize:16];
    _rightLabel.textColor=[UIColor redColor];
    _rightLabel.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:_rightLabel];
    
    return self;
}

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
-(void)setLabelValue:(NSString*)title normal:(BOOL)isNormal
{
    if (isNormal) {
        _rightLabel.textColor=[UIColor colorFromHexRGB:@"666666"];
    }
    _rightLabel.text=title;
    
}
- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGSize size=[_leftLabel.text textSize:[UIFont boldSystemFontOfSize:16] withWidth:self.bounds.size.width];
    CGRect frame=_leftLabel.frame;
    frame.origin.x=10;
    frame.origin.y=(self.bounds.size.height-size.height)/2.0;
    frame.size=size;
    _leftLabel.frame=frame;
    
    size=[_rightLabel.text textSize:[UIFont boldSystemFontOfSize:16] withWidth:self.bounds.size.width];
    CGRect r = _rightLabel.frame;
	r.origin.x = _leftLabel.frame.origin.x+_leftLabel.frame.size.width+2;
    r.origin.y=(self.bounds.size.height-size.height)/2.0;
	r.size=size;
	_rightLabel.frame = r;
    
    
}
@end
