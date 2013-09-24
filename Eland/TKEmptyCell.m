//
//  TKEmptyCell.m
//  ElandSearch
//
//  Created by rang on 13-8-11.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKEmptyCell.h"

@implementation TKEmptyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
