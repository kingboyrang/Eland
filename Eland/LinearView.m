//
//  LinearView.m
//  Eland
//
//  Created by aJia on 13/9/24.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "LinearView.h"
#import "UIColor+TPCategory.h"

@implementation LinearView
@synthesize linarStartColor=_linarStartColor;
@synthesize linarEndColor=_linarEndColor;
-(void)dealloc{
    [super dealloc];
    [_linarStartColor release],_linarStartColor=nil;
    [_linarEndColor release],_linarEndColor=nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.linarStartColor=[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0];
        self.linarEndColor=[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.0];
    }
    return self;
}
-(void)setStartLinarColor:(UIColor*)startColor endColor:(UIColor*)endColor{
    [self setLinarStartColor:startColor];
    [self setLinarEndColor:endColor];
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    // 创建起点颜色 白色
    CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){self.linarStartColor.red,self.linarStartColor.green,self.linarStartColor.blue,self.linarStartColor.alpha});
    // 创建终点颜色 灰色 RGB(212,212,212) 这个色值我们可以从chroma扩展插件中选择
    CGColorRef endColor = CGColorCreate(colorSpaceRef, (CGFloat[]){self.linarEndColor.red, self.linarEndColor.green,self.linarEndColor.blue, self.linarEndColor.alpha});
    //画线性
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0,1.0};
    NSArray *colors = [NSArray arrayWithObjects:( id)beginColor,(id)endColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)CFBridgingRetain(colors), locations);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);//裁剪
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    //add line stroke
    CGRect strokeRect =rect; //CGRectInset(paperRect, 5.0, 5.0);
    CGColorRef lineColor = CGColorCreate(colorSpaceRef, (CGFloat[]){self.linarEndColor.red, self.linarEndColor.green,self.linarEndColor.blue, self.linarEndColor.alpha});
    CGContextSetStrokeColorWithColor(context, lineColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, strokeRect);
     
}
@end
