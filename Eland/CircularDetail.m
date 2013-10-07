//
//  CircularDetail.m
//  CellDemo
//
//  Created by rang on 13-8-31.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CircularDetail.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+TPCategory.h"
#import "NSString+TPCategory.h"
#import "LevelCase.h"
@interface CircularDetail ()
-(CGSize)CalculateStringSize:(NSString*)content font:(UIFont*)font with:(CGFloat)w;
-(void)addLabel:(NSString*)text frame:(CGRect)frame;
-(void)addLineLabel:(CGRect)frame;
-(CGFloat)addImageTitle:(NSString*)title;
-(UILabel*)createLabel:(CGRect)frame;
-(void)resetLableTitle:(NSString*)title;
@end

@implementation CircularDetail
@synthesize labTitle=_labTitle;
@synthesize labNumber=_labNumber;
@synthesize labCategory=_labCategory;
@synthesize labTime=_labTime;
@synthesize labStatus=_labStatus;
-(void)dealloc{
    [super dealloc];
    [innerView release],innerView=nil;
    [_imageView release],_imageView=nil;
    [_labTitle release],_labTitle=nil;
    [_labNumber release],_labNumber=nil;
    [_labCategory release],_labCategory=nil;
    [_labTime release],_labTime=nil;
    if (_labStatus) {
        [_labStatus release],_labStatus=nil;
    }
    
}
-(id)initWithTitle:(NSString*)title frame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self resetLableTitle:[title Trim]];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
        
        CGRect rect=CGRectInset(self.bounds, 20, 0);
        innerView=[[UIView alloc] initWithFrame:rect];
        innerView.backgroundColor=[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
        //[UIColor colorFromHexRGB:@"c8eaed"];
        //[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
        //[UIColor colorFromHexRGB:@"ceea1a"];
        //[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
        //将图层的边框设置为圆脚
        innerView.layer.borderColor=[UIColor whiteColor].CGColor;
        //[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor;
        innerView.layer.cornerRadius = 5.0;
        //innerView.layer.masksToBounds = YES;
        innerView.layer.borderWidth=2.0;
        innerView.autoresizesSubviews=YES;
        innerView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth;
        [self addSubview:innerView];
       
        //姓名
        CGFloat topY= [self addImageTitle:@"吳瀾洲"];
        //画线
        [self addLineLabel:CGRectMake(0, topY, innerView.frame.size.width,1)];
        //案件编号
        topY+=5;
        CGSize size=[self CalculateStringSize:@"案件編號:" font:[UIFont boldSystemFontOfSize:14] with:innerView.frame.size.width];
        [self addLabel:@"案件編號:" frame:CGRectMake(5, topY, size.width, size.height)];
        //案件编号值
        CGFloat leftX=5+size.width+2;
        self.labNumber=[self createLabel:CGRectMake(leftX, topY, innerView.frame.size.width-leftX, size.height)];
        [innerView addSubview:self.labNumber];
         //案件类别
        topY+=size.height+2;
        size=[self CalculateStringSize:@"案件類別:" font:[UIFont boldSystemFontOfSize:14] with:innerView.frame.size.width];
        [self addLabel:@"案件類別:" frame:CGRectMake(5, topY, size.width, size.height)];
        //案件类别值
        leftX=5+size.width+2;      
        self.labCategory=[self createLabel:CGRectMake(leftX, topY, innerView.frame.size.width-leftX, size.height)];
        [innerView addSubview:self.labCategory];
        //画线
        topY+=5+size.height;
        [self addLineLabel:CGRectMake(0, topY, innerView.frame.size.width,1)];
        //底部
        topY+=1;
        UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, topY, innerView.frame.size.width, 30)];
        topView.backgroundColor=[UIColor clearColor];
        topView.autoresizesSubviews=YES;
        topView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        //通报时间
         size=[self CalculateStringSize:@"通報時間:" font:[UIFont boldSystemFontOfSize:14] with:innerView.frame.size.width];
        UILabel *labelTime=[[UILabel alloc] initWithFrame:CGRectMake(5,(30-size.height)/2,size.width,size.height)];
        labelTime.font=[UIFont boldSystemFontOfSize:14];
        labelTime.textColor=[UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
        labelTime.backgroundColor=[UIColor clearColor];
        labelTime.text=@"通報時間:";
        [topView addSubview:labelTime];
        [labelTime release];
        
        self.labTime=[self createLabel:CGRectMake(7+size.width,(30-size.height)/2,innerView.frame.size.width-7-size.width, size.height)];
        [topView addSubview:self.labTime];
        
        CGSize textSize=[self CalculateStringSize:@"辦理中" font:[UIFont boldSystemFontOfSize:14] with:innerView.frame.size.width];
        self.labStatus=[[UILabel alloc] initWithFrame:CGRectMake(topView.frame.size.width-textSize.width-20-2,(30-textSize.height)/2, textSize.width+20, textSize.height)];
        self.labStatus.text=@"辦理中";
        self.labStatus.textAlignment=NSTextAlignmentCenter;
        self.labStatus.textColor=[UIColor whiteColor];
        self.labStatus.backgroundColor=[UIColor redColor];
        self.labStatus.layer.borderWidth=0.0;
        self.labStatus.layer.cornerRadius=10.0;
        self.labStatus.autoresizesSubviews=YES;
        self.labStatus.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
        [topView addSubview:self.labStatus];
        
        [innerView addSubview:topView];
        [topView release];
        //重设大小
        CGRect orginframe=innerView.frame;
        orginframe.size.height=topY+30;
        innerView.frame=orginframe;
        //NSLog(@"frame:%@\n",NSStringFromCGRect(innerView.frame));
        //添加四个边阴影
        innerView.layer.shadowColor =[UIColor colorFromHexRGB:@"20a6b3"].CGColor;
        innerView.layer.shadowOffset = CGSizeMake(5, 5);
        innerView.layer.shadowOpacity = 0.5;
        innerView.layer.shadowRadius=8.0;
    }
    return self;
}
-(void)selectedBgColorAnimal:(BOOL)animal{
    if (animal) {
        innerView.backgroundColor=[UIColor colorFromHexRGB:@"c1e7eb"];
    }else{
    innerView.backgroundColor=[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    }
}
-(void)setDataSource:(LevelCase*)args{
    
    NSString *strTitle=[args.Nick Trim];
    [self resetLableTitle:strTitle];
    
    self.labNumber.text=[args GUID];
    self.labCategory.text=[args CategoryName];
    self.labTime.text=[args formatDataTw];
    if (![args.Status isEqualToString:@"1"]) {
        self.labStatus.backgroundColor=[UIColor colorWithRed:0.25098 green:0.501961 blue:0 alpha:1];
        self.labStatus.text=[args StatusText];
    }
}
#pragma mark 私有方法
-(void)resetLableTitle:(NSString*)title{
    CGSize size=[self CalculateStringSize:title font:[UIFont boldSystemFontOfSize:14] with:self.bounds.size.width];
    
    _imageView.frame=CGRectMake(0, 10,size.width+14,size.height+8);
    UIImage *image=[UIImage imageNamed:@"cell_title.png"];
    UIEdgeInsets insets = UIEdgeInsetsMake(4, 7, 4, 7);
    image = [image resizableImageWithCapInsets:insets];
    [_imageView setImage:image];
    
    self.labTitle.frame=CGRectMake(7, 14, size.width, size.height);
    self.labTitle.text=title;
}
-(UILabel*)createLabel:(CGRect)frame{
    UILabel *label=[[UILabel alloc] initWithFrame:frame];
    label.font=[UIFont boldSystemFontOfSize:14];
    label.textColor=[UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
    label.backgroundColor=[UIColor clearColor];
    return [label autorelease];
}
-(CGFloat)addImageTitle:(NSString*)title{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectZero];
    CGSize size=[self CalculateStringSize:title font:[UIFont boldSystemFontOfSize:14] with:innerView.frame.size.width];
    
    label.frame=CGRectMake(7, 14, size.width, size.height);
    label.font=[UIFont  boldSystemFontOfSize:14];
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor whiteColor];
    label.text=title;
    self.labTitle=label;
    
    _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 10,size.width+14,size.height+8)];
    UIImage *image=[UIImage imageNamed:@"cell_title.png"];
    UIEdgeInsets insets = UIEdgeInsetsMake(4, 7, 4, 7);
    image = [image resizableImageWithCapInsets:insets];
    [_imageView setImage:image];
    [self addSubview:_imageView];
    
    [self addSubview:label];
    [label release];
    
    return size.height+22;

}
-(void)addLineLabel:(CGRect)frame{
    UILabel *lineLabel=[[UILabel alloc] initWithFrame:frame];
    lineLabel.backgroundColor=[UIColor colorFromHexRGB:@"679fc4"];
    lineLabel.autoresizesSubviews=YES;
    lineLabel.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    [innerView addSubview:lineLabel];
    [lineLabel release];
}
-(void)addLabel:(NSString*)text frame:(CGRect)frame{
    UILabel *numberLabel=[[UILabel alloc] initWithFrame:frame];
    numberLabel.font=[UIFont boldSystemFontOfSize:14];
    numberLabel.textColor=[UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
    numberLabel.backgroundColor=[UIColor clearColor];
    numberLabel.text=text;
    [innerView addSubview:numberLabel];
    [numberLabel release];
}
-(CGSize)CalculateStringSize:(NSString*)content font:(UIFont*)font with:(CGFloat)w{
    CGSize textSize = [content sizeWithFont:font
                       constrainedToSize:CGSizeMake(w, CGFLOAT_MAX)
                           lineBreakMode:NSLineBreakByWordWrapping];
    return textSize;
}

@end
