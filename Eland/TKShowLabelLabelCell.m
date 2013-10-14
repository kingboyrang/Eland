//
//  TKShowLabelLabelCell.m
//  Eland
//
//  Created by aJia on 13/10/14.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKShowLabelLabelCell.h"
#import "UIColor+TPCategory.h"
#import "NSString+TPCategory.h"
@implementation TKShowLabelLabelCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
	
	_rightlabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _rightlabel.font = [UIFont boldSystemFontOfSize:16.0];
	_rightlabel.backgroundColor = [UIColor clearColor];
    _rightlabel.textColor=[UIColor colorFromHexRGB:@"666666"];
    _rightlabel.numberOfLines=0;
    _rightlabel.lineBreakMode=NSLineBreakByWordWrapping;
	[self.contentView addSubview:_rightlabel];
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self=[self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
	CGRect r = CGRectInset(self.contentView.bounds, 8, 8);
	r.origin.x += self.label.frame.size.width + 6;
	r.size.width -= self.label.frame.size.width + 6;
    
    CGSize size=[_rightlabel.text textSize:[UIFont boldSystemFontOfSize:16.0] withWidth:r.size.width];
    if (size.height>r.size.height) {
        r.size.height=size.height;
    }
	_rightlabel.frame = r;
	
}


@end
