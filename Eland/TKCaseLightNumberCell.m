//
//  TKCaseLightNumberCell.m
//  Eland
//
//  Created by aJia on 2013/11/22.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseLightNumberCell.h"
@implementation TKCaseLightNumberCell
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    _lightNumber=[[SwitchLightNumber alloc] initWithFrame:CGRectMake(0,0, 300, 30)];
	[self.contentView addSubview:_lightNumber];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
@end
