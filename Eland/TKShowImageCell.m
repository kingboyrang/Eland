//
//  TKShowImageCell.m
//  Eland
//
//  Created by aJia on 13/10/16.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKShowImageCell.h"

@implementation TKShowImageCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;

    _PhotoScroll=[[MKPhotoScroll alloc] initWithFrame:CGRectMake((self.bounds.size.width-296)/2.0, 2, 296, 296)];
    _PhotoScroll.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:_PhotoScroll];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    /***
    CGRect r=_PhotoScroll.frame;
    r.origin.x=(self.bounds.size.width-r.size.width)/2.0;
    r.origin.y=(300-r.size.height)/2.0;
    _PhotoScroll.frame=r;
    NSLog(@"frame=%@\n",NSStringFromCGRect(r));
     ***/
}

@end
