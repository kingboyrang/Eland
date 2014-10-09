//
//  PushDetail.m
//  Eland
//
//  Created by aJia on 13/10/9.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "PushDetail.h"
#import "NSString+TPCategory.h"
#import "UIColor+TPCategory.h"
@interface PushDetail ()
-(void)loadControls;
@end


@implementation PushDetail
@synthesize labSubject=_labSubject;
@synthesize labBody=_labBody;
@synthesize labApplyDate=_labApplyDate;
-(void)dealloc{
    [super dealloc];
    [_labSubject release],_labSubject=nil;
    [_labBody release],_labBody=nil;
    [_labApplyDate release],_labApplyDate=nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadControls];
        self.backgroundColor=[UIColor colorFromHexRGB:@"f4f4f4"];
    }
    return self;
}
-(void)loadControls{
    CGFloat fontSize=14,leftX=10;
    _labSubject=[[UILabel alloc] initWithFrame:CGRectMake(leftX, 2, self.bounds.size.width,0)];
    _labSubject.font=[UIFont boldSystemFontOfSize:fontSize];
    _labSubject.textColor=[UIColor blackColor];
    _labSubject.backgroundColor=[UIColor clearColor];
    _labSubject.numberOfLines=0;
    _labSubject.lineBreakMode=NSLineBreakByWordWrapping;
    [self addSubview:_labSubject];
    
    _labBody=[[UILabel alloc] initWithFrame:CGRectMake(leftX,0, 0, 0)];
    _labBody.font=[UIFont boldSystemFontOfSize:fontSize];
    _labBody.textColor=[UIColor colorFromHexRGB:@"666666"];
    _labBody.backgroundColor=[UIColor clearColor];
    _labBody.numberOfLines=0;
    _labBody.lineBreakMode=NSLineBreakByWordWrapping;
    [self addSubview:_labBody];
    
    
    
    _labApplyDate=[[UILabel alloc] initWithFrame:CGRectMake(leftX, 2, 0, 0)];
    _labApplyDate.font=[UIFont boldSystemFontOfSize:fontSize];
    _labApplyDate.textColor=[UIColor colorFromHexRGB:@"3DB5C0"];
    _labApplyDate.backgroundColor=[UIColor clearColor];
    [self addSubview:_labApplyDate];

}
-(void)setDataSource:(PushResult*)args{
    
    self.labSubject.text=args.Subject;
    self.labBody.text=args.HtmlBody;
    self.labApplyDate.text=[args formatDataTw];
    
    [self setNeedsDisplay];
}
-(void)layoutSubviews{
    [super layoutSubviews];
   CGSize size=[_labApplyDate.text textSize:_labApplyDate.font withWidth:self.bounds.size.width];
   CGRect frame=_labApplyDate.frame;
    frame.origin.x=self.bounds.size.width-size.width-20;
    frame.size=size;
    _labApplyDate.frame=frame;
    
    frame=_labSubject.frame;
    frame.size.width=_labApplyDate.frame.origin.x-frame.origin.x-2;
    size=[_labSubject.text textSize:_labSubject.font withWidth:frame.size.width];
    frame.size.height=size.height;
    _labSubject.frame=frame;
   
    
    NSString *memo=[_labBody.text Trim];
    size=[memo textSize:_labBody.font withWidth:self.bounds.size.width-30];
    frame=_labBody.frame;
    frame.origin.y=_labSubject.frame.origin.y+_labSubject.frame.size.height+2;
    frame.size=size;
    /***
    if (size.height>self.bounds.size.height-frame.origin.y) {
        frame.size.height=self.bounds.size.height-frame.origin.y-2;
    }
     ***/
    _labBody.frame=frame;
    
    CGRect r=self.frame;
    r.size.height=frame.origin.y+frame.size.height+2;
    self.frame=r;
  
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
