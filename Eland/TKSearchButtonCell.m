//
//  TKSearchButtonCell.m
//  Eland
//
//  Created by rang on 13-10-8.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKSearchButtonCell.h"

@implementation TKSearchButtonCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
        // Initialization code
        
    UIImage *leftImage=[UIImage imageNamed:@"btn.png"];
    UIEdgeInsets leftInsets = UIEdgeInsetsMake(5,10, 5, 10);
    leftImage=[leftImage resizableImageWithCapInsets:leftInsets resizingMode:UIImageResizingModeStretch];
    
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame=CGRectMake(0, 0, 100, 40);
    [_button setBackgroundImage:leftImage forState:UIControlStateNormal];
    _button.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button setTitle:@"查詢" forState:UIControlStateNormal];
    [self.contentView addSubview:_button];
    
    UIView *tempView = [[[UIView alloc] init] autorelease];
    [self setBackgroundView:tempView];
    [self setBackgroundColor:[UIColor clearColor]];
    
    return self;
}

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
   
	CGRect frame = [self.button frame];
    frame.origin.y=(self.bounds.size.height-frame.size.height)/2.0;
    frame.origin.x=(self.bounds.size.width-frame.size.width)/2.0;
	[self.button setFrame:frame];
    
}

@end
