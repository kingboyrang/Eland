//
//  MenuSegment.m
//  Eland
//
//  Created by aJia on 13/10/1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "MenuBar.h"
#import "UIColor+TPCategory.h"
#import "UIImage+TPCategory.h"
@interface MenuBar ()
-(void)loadControls;
-(void)selectedButton:(id)sender;
- (void)handleAutoScrolling:(BOOL)animated;
@end

@implementation MenuBar
@synthesize selectedIndex=_selectedIndex;
@synthesize controlers;
-(void)dealloc{
    [super dealloc];
    [_scrollView release],_scrollView=nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorFromHexRGB:@"3db5c0"];
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.backgroundColor=[UIColor clearColor];
        _scrollView.scrollEnabled=YES;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
        _scrollView.delegate=self;
        _prevSelectedIndex=0;
        _selectedIndex=0;
        [self loadControls];
    }
    return self;
}
-(void)loadControls{
    CGFloat w=80,h=30;
    if (DeviceIsPad) {
        w=150;
        h=58;
    }
   
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(0, 0, w, h);
    btn1.tag=100;
    btn1.selected=YES;
    [btn1 setBackgroundImage:[UIImage imageNamed:DeviceIsPad?@"repair_normal.png":@"iphone_repair_normal.png"] forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageNamed:DeviceIsPad?@"repair_select.png":@"iphone_repair_select.png"] forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btn1];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(w, 0, w, h);
    btn2.tag=101;
    [btn2 setBackgroundImage:[UIImage imageNamed:DeviceIsPad?@"search_normal.png":@"iphone_search_normal.png"]  forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:DeviceIsPad?@"search_select.png":@"iphone_search_select.png"]  forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btn2];
    
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame=CGRectMake(2*w, 0, w, h);
    btn3.tag=102;
    [btn3 setBackgroundImage:[UIImage imageNamed:DeviceIsPad?@"push_normal.png":@"iphone_push_normal.png"]  forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageNamed:DeviceIsPad?@"push_select.png":@"iphone_push_select.png"]  forState:UIControlStateSelected];
    [btn3 addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btn3];
    
    UIButton *btn4=[UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame=CGRectMake(3*w, 0, w, h);
    btn4.tag=103;
    [btn4 setBackgroundImage:[UIImage imageNamed:DeviceIsPad?@"bussiness_normal.png":@"iphone_bussiness_normal.png"] forState:UIControlStateNormal];
    [btn4 setBackgroundImage:[UIImage imageNamed:DeviceIsPad?@"bussiness_select.png":@"iphone_bussiness_select.png"]  forState:UIControlStateSelected];
    [btn4 addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btn4];
    
    CGFloat totalW=4*w;
    CGFloat leftX=DeviceWidth<totalW?0:(self.bounds.size.width-totalW)/2;
    
    _scrollView.contentSize=CGSizeMake(totalW, h);
    _scrollView.frame=CGRectMake(leftX,(self.bounds.size.height-h)/2.0,self.bounds.size.width, h);
    
    [self addSubview:_scrollView];
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame=_scrollView.frame;
    CGFloat w=self.bounds.size.width;
    if (w<_scrollView.contentSize.width) {
        frame.origin.x=0;
        frame.size.width=w;
    }else{
        frame.origin.x=(w-_scrollView.contentSize.width)/2.0;
        frame.size.width=_scrollView.contentSize.width;
    }
    _scrollView.frame=frame;
    [self handleAutoScrolling:YES];
}
-(void)setSelectedItemIndex:(int)index{
     _selectedIndex=index;
    UIButton *btn1=(UIButton*)[_scrollView viewWithTag:index+100];
    btn1.selected=YES;
    
    UIButton *btn2=(UIButton*)[_scrollView viewWithTag:_prevSelectedIndex+100];
    btn2.selected=NO;
    
    _prevSelectedIndex=index;
    [self handleAutoScrolling:YES];
    
    if (self.controlers&&[self.controlers respondsToSelector:@selector(selectedMenuItemIndex:)]) {
        [self.controlers performSelector:@selector(selectedMenuItemIndex:) withObject:_selectedIndex];
    }
}
-(void)selectedButton:(id)sender{
    UIButton *btn=(UIButton*)sender;
    btn.selected=YES;
    if (btn.tag-100==_selectedIndex) {
        return;
    }
     _selectedIndex=btn.tag-100;
    UIButton *btn1=(UIButton*)[_scrollView viewWithTag:_prevSelectedIndex+100];
    btn1.selected=NO;
    
    _prevSelectedIndex=btn.tag-100;
    
    [self handleAutoScrolling:YES];
    
    if (self.controlers&&[self.controlers respondsToSelector:@selector(selectedMenuItemIndex:)]) {
        [self.controlers performSelector:@selector(selectedMenuItemIndex:) withObject:_selectedIndex];
    }
}
- (void)handleAutoScrolling:(BOOL)animated {
    CGFloat leftX=(_selectedIndex+1)*(_scrollView.contentSize.width/4)-_scrollView.bounds.size.width;
    if (leftX<0) {
        leftX=0;
    }
    [_scrollView setContentOffset:CGPointMake(leftX, 0) animated:animated];
}
@end
