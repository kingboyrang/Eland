//
//  ChooseRadioView.m
//  Eland
//
//  Created by aJia on 2013/11/28.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "ChooseRadioView.h"

@interface ChooseRadioView ()
-(void)loadControls:(CGRect)frame;
-(void)buttonClickTap:(id)sender;
-(void)addButton:(CGFloat)leftx height:(CGFloat)h index:(NSInteger)tag;
@end

@implementation ChooseRadioView
@synthesize currentIndex;
-(void)dealloc{
    [super dealloc];
    [_lightLabel release],_lightLabel=nil;
    [_addressLabel release],_addressLabel=nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadControls:frame];
        
    }
    return self;
}
-(void)loadControls:(CGRect)frame{
    CGFloat leftx=16;
    [self addButton:leftx height:frame.size.height index:100];
    leftx+=20+1;
    
    if (!_lightLabel) {
        _lightLabel=[[UILabel alloc] initWithFrame:CGRectMake(leftx,(frame.size.height-19)/2.0,25, 19)];
        _lightLabel.font=[UIFont boldSystemFontOfSize:15.0];
        _lightLabel.text=@"是";
        _lightLabel.backgroundColor=[UIColor clearColor];
        _lightLabel.textColor=[UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
        leftx+=25+2;
    }
    [self addSubview:_lightLabel];
    [self addButton:leftx height:frame.size.height index:101];
    leftx+=20+1;
    
    if (!_addressLabel) {
        _addressLabel=[[UILabel alloc] initWithFrame:CGRectMake(leftx,(frame.size.height-19)/2.0,61, 19)];
        _addressLabel.font=[UIFont boldSystemFontOfSize:15.0];
        _addressLabel.text=@"否";
        _addressLabel.backgroundColor=[UIColor clearColor];
        _addressLabel.textColor=[UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
    }
    self.currentIndex=1;
    [self addSubview:_addressLabel];
}
-(void)addButton:(CGFloat)leftx height:(CGFloat)h index:(NSInteger)tag{
    UIImage *image=[UIImage imageNamed:@"checkbox.png"];
    UIImage *imageSelect=[UIImage imageNamed:@"checkbox-checked.png"];
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(leftx,(h-image.size.width)/2.0, image.size.width, image.size.height);
    btn1.tag=tag;
    [btn1 setImage:image forState:UIControlStateNormal];
    [btn1 setImage:imageSelect forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(buttonClickTap:) forControlEvents:UIControlEventTouchUpInside];
    if (tag==100) {
        btn1.selected=YES;
    }
    [self addSubview:btn1];
}
-(void)buttonClickTap:(id)sender{
    UIButton *btn=(UIButton*)sender;
    NSInteger pos=btn.tag==100?101:100;
    UIButton *btn1=(UIButton*)[self viewWithTag:pos];
    btn.selected=YES;
    btn1.selected=NO;
    self.currentIndex=btn.tag==100?1:2;
    
}
-(void)setSelectedIndex:(int)index{
    id btn=[self viewWithTag:100+index];
    [self buttonClickTap:btn];
}
-(NSString*)radioValue{
    if (self.currentIndex==1) {
        return @"是";
    }
    return @"否";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
