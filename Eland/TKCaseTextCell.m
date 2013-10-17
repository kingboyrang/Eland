//
//  TKCaseTextCell.m
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseTextCell.h"
#import "NSString+TPCategory.h"
@implementation TKCaseTextCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
	_label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont boldSystemFontOfSize:16.0];
    _label.numberOfLines=0;
    _label.lineBreakMode=NSLineBreakByWordWrapping;
	[self.contentView addSubview:_label];
    
    
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
	
    CGSize size=[self.label.text textSize:[UIFont boldSystemFontOfSize:16.0] withWidth:self.bounds.size.width-10*2];
    CGRect r=CGRectInset(self.bounds, 10, 4);
    r.size=size;
	
	[self.label setFrame:r];
    
}


@end
