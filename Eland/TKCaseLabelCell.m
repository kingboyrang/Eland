//
//  TKCaseLabelCell.m
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseLabelCell.h"
#import "UIColor+TPCategory.h"
@implementation TKCaseLabelCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
   
    _label = [[RTLabel alloc] initWithFrame:CGRectZero];
	_label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.textColor = [UIColor colorFromHexRGB:@"3DB5C0"];
    _label.font = [UIFont boldSystemFontOfSize:16.0];
	[self.contentView addSubview:_label];
    
    
    
    return self;
}
-(void)setLabelName:(NSString *)title required:(BOOL)required{
    NSString *showTitle=[NSString stringWithFormat:@"<font face='HelveticaNeue-CondensedBold' size=16 color='#3DB5C0'>%@</font>",title];
    NSString *requiredTitle=@"";
    if (required) {
        requiredTitle=@"<font size=16 color='#dd1100'>*</font>";
    }
    [_label setText:[NSString stringWithFormat:@"%@%@",showTitle,requiredTitle]];
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
	
    CGSize optimumSize = [self.label optimumSize];
	CGRect frame = [self.label frame];
    frame.size.width=optimumSize.width;
	frame.size.height = (int)optimumSize.height + 5;
    frame.origin.y=(30-frame.size.height)/2.0;
    frame.origin.x=10;
	[self.label setFrame:frame];
    
}
@end
