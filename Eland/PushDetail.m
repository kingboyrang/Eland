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
   //CGSize size=
    
    _labSubject=[[UILabel alloc] initWithFrame:CGRectMake(leftX, 2, self.bounds.size.width,0)];
    _labSubject.font=[UIFont boldSystemFontOfSize:fontSize];
    _labSubject.textColor=[UIColor blackColor];
    _labSubject.backgroundColor=[UIColor clearColor];
    [self addSubview:_labSubject];
    
    _labBody=[[UILabel alloc] initWithFrame:CGRectMake(leftX,0, 0, 0)];
    _labBody.font=[UIFont boldSystemFontOfSize:fontSize];
    _labBody.textColor=[UIColor colorFromHexRGB:@"666666"];
    _labBody.backgroundColor=[UIColor clearColor];
    [self addSubview:_labBody];
    
    
    
    _labApplyDate=[[UILabel alloc] initWithFrame:CGRectMake(leftX, 2, 0, 0)];
    _labApplyDate.font=[UIFont boldSystemFontOfSize:fontSize];
    _labApplyDate.textColor=[UIColor colorFromHexRGB:@"3DB5C0"];
    _labApplyDate.backgroundColor=[UIColor clearColor];
    [self addSubview:_labApplyDate];

}
-(void)setDataSource:(PushResult*)args{
    
    
    self.labSubject.text=args.Subject;
    self.labBody.text=args.Body;
    self.labApplyDate.text=[args formatDataTw];
    
    [self setNeedsLayout];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size=[_labApplyDate.text textSize:[UIFont boldSystemFontOfSize:14] withWidth:self.bounds.size.width];
    CGRect frame=_labApplyDate.frame;
    frame.origin.x=self.bounds.size.width-size.width-5;
    frame.size=size;
    _labApplyDate.frame=frame;
    
     size=[_labSubject.text textSize:[UIFont boldSystemFontOfSize:14] withWidth:self.bounds.size.width];
     frame=[_labSubject frame];
    frame.size=size;
    frame.size.width=self.bounds.size.width-_labApplyDate.frame.origin.x-2;
    _labSubject.frame=frame;
    
    
    
    size=[_labBody.text textSize:[UIFont boldSystemFontOfSize:14] withWidth:self.bounds.size.width];
    frame=_labBody.frame;
    frame.origin.y=_labSubject.frame.origin.y+_labSubject.frame.size.height+2;
    frame.size=size;
    frame.size.width-=10;
    _labBody.frame=frame;    
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
