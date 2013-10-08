//
//  SearchDetail.m
//  Eland
//
//  Created by rang on 13-10-8.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "SearchDetail.h"
#import "UIColor+TPCategory.h"
#import "NSString+TPCategory.h"
@interface SearchDetail (){
    UILabel *_labNickMemo;
}
-(void)loadControls;
@end

@implementation SearchDetail
@synthesize labNick=_labNick;
@synthesize labNumber=_labNumber;
@synthesize labCategory=_labCategory;
@synthesize labApplyDate=_labApplyDate;
@synthesize labStatus=_labStatus;
-(void)dealloc{
    [super dealloc];
    [_labNick release],_labNick=nil;
    [_labNumber release],_labNumber=nil;
    [_labCategory release],_labCategory=nil;
    [_labApplyDate release],_labApplyDate=nil;
    [_labStatus release],_labStatus=nil;
    [_labNickMemo release],_labNickMemo=nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self loadControls];
    }
    return self;
}
-(void)loadControls{
    CGFloat fontSize=14,leftX=10;
    CGSize size=[@"暱稱:" textSize:[UIFont boldSystemFontOfSize:fontSize] withWidth:self.bounds.size.width];
    _labNickMemo=[[UILabel alloc] initWithFrame:CGRectMake(leftX, 2, size.width, size.height)];
    _labNickMemo.font=[UIFont boldSystemFontOfSize:fontSize];
    _labNickMemo.textColor=[UIColor blackColor];
    _labNickMemo.text=@"暱稱:";
    _labNickMemo.backgroundColor=[UIColor clearColor];
    [self addSubview:_labNickMemo];
    
    _labNick=[[UILabel alloc] initWithFrame:CGRectMake(_labNickMemo.frame.origin.x+size.width+2, 2, size.width, size.height)];
    _labNick.font=[UIFont boldSystemFontOfSize:fontSize];
    _labNick.textColor=[UIColor blackColor];
    _labNick.backgroundColor=[UIColor clearColor];
    [self addSubview:_labNick];
    
    _labNumber=[[UILabel alloc] initWithFrame:CGRectMake(leftX, 4+size.height, 0, 0)];
    _labNumber.font=[UIFont boldSystemFontOfSize:fontSize];
    _labNumber.textColor=[UIColor colorFromHexRGB:@"3DB5C0"];
        _labNumber.backgroundColor=[UIColor clearColor];
    [self addSubview:_labNumber];
    
    _labCategory=[[UILabel alloc] initWithFrame:CGRectMake(leftX, 4+size.height, 0, 0)];
    _labCategory.font=[UIFont boldSystemFontOfSize:fontSize];
    _labCategory.textColor=[UIColor colorFromHexRGB:@"3DB5C0"];
    _labCategory.backgroundColor=[UIColor clearColor];
    [self addSubview:_labCategory];
    
    _labApplyDate=[[UILabel alloc] initWithFrame:CGRectMake(leftX, 2, size.width, size.height)];
    _labApplyDate.font=[UIFont boldSystemFontOfSize:fontSize];
    _labApplyDate.textColor=[UIColor blackColor];
        _labApplyDate.backgroundColor=[UIColor clearColor];
    [self addSubview:_labApplyDate];
    
    _labStatus=[[UILabel alloc] initWithFrame:CGRectMake(leftX, 2, size.width, size.height)];
    _labStatus.font=[UIFont boldSystemFontOfSize:fontSize];
    _labStatus.textColor=[UIColor redColor];
    _labStatus.backgroundColor=[UIColor clearColor];
    [self addSubview:_labStatus];

}
-(void)setDataSource:(LevelCase*)args{
    self.labNick.text=args.Nick;
    self.labNumber.text=[args GUID];
    self.labCategory.text=[args CategoryName];
    self.labApplyDate.text=[args formatDataTw];
    if (![args.Status isEqualToString:@"1"]) {
        self.labStatus.textColor=[UIColor colorWithRed:0.25098 green:0.501961 blue:0 alpha:1];
    }
    self.labStatus.text=[args StatusText];
    [self setNeedsLayout];

}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size=[_labNick.text textSize:[UIFont boldSystemFontOfSize:14] withWidth:self.bounds.size.width];
    CGRect frame=[_labNick frame];
    frame.size.width=size.width;
    _labNick.frame=frame;
    
    size=[_labNumber.text textSize:[UIFont boldSystemFontOfSize:14] withWidth:self.bounds.size.width];
    frame=_labNumber.frame;
    frame.size=size;
    _labNumber.frame=frame;
    
    size=[_labCategory.text textSize:[UIFont boldSystemFontOfSize:14] withWidth:self.bounds.size.width];
    frame=_labCategory.frame;
    frame.origin.x=_labNumber.frame.origin.x+_labNumber.frame.size.width+5;
    frame.origin.y=_labNumber.frame.origin.y;
    frame.size=size;
    _labCategory.frame=frame;
    
    size=[_labApplyDate.text textSize:[UIFont boldSystemFontOfSize:14] withWidth:self.bounds.size.width];
    frame=_labApplyDate.frame;
    frame.origin.y=_labNumber.frame.origin.y+_labNumber.frame.size.height+2;
    frame.size=size;
    _labApplyDate.frame=frame;
    
    size=[_labStatus.text textSize:[UIFont boldSystemFontOfSize:14] withWidth:self.bounds.size.width];
    frame.origin.x=self.bounds.size.width-size.width-5;
    frame.origin.y=(_labApplyDate.frame.size.height+_labApplyDate.frame.origin.y+2-size.height)/2.0;
    frame.size=size;
    _labStatus.frame=frame;
   
    if (![_labStatus.text isEqualToString:@"辦理中"]) {
        _labStatus.textColor=[UIColor colorWithRed:0.25098 green:0.501961 blue:0 alpha:1];
    }else{
       _labStatus.textColor=[UIColor redColor];
    }
}
@end
