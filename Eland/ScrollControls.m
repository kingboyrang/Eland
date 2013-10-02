//
//  ScrollControls.m
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "ScrollControls.h"

@interface ScrollControls ()
- (void)handleAutoScrolling:(BOOL)animated;
@end

@implementation ScrollControls
@synthesize selectedIndex=_selectedIndex;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled=YES;
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        self.backgroundColor=[UIColor clearColor];
        _selectedIndex=0;
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame=self.frame;
    self.contentSize=CGSizeMake(frame.size.width*4, frame.size.height);
    [self handleAutoScrolling:YES];
}
-(void)setSelectedItemIndex:(int)index{
    _selectedIndex=index;
    [self handleAutoScrolling:NO];
}
- (void)handleAutoScrolling:(BOOL)animated{
   [self setContentOffset:CGPointMake(_selectedIndex*self.bounds.size.width, 0) animated:animated];
}
@end
