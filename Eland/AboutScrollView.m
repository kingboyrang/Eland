//
//  AboutScrollView.m
//  Eland
//
//  Created by aJia on 13/9/30.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "AboutScrollView.h"

@interface AboutScrollView (){
    RTLabel *_label;
}

@end

@implementation AboutScrollView
- (void)dealloc{
    [super dealloc];
    [_label release],_label=nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator=NO;
        self.pagingEnabled=YES;
        self.autoresizesSubviews=YES;
        self.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.backgroundColor=[UIColor clearColor];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"aboutUs" ofType:@"txt"];
        NSString *content=[[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] autorelease];
        _label=[[RTLabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
        _label.delegate=self;
        [_label setText:content];
        [self addSubview:_label];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize optimumSize = [_label optimumSize];
	CGRect frame =[_label frame];
	frame.size.height = (int)optimumSize.height + 5;
    frame.size.width=self.bounds.size.width;
	[_label setFrame:frame];
    [_label setNeedsDisplay];
    [self setContentSize:CGSizeMake(self.bounds.size.width, frame.size.height)];
}
#pragma mark -
#pragma mark RTLabelDelegate Methods
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url{
    [AlertHelper initWithTitle:@"提示" message:@"是否前往瀏覽?" cancelTitle:@"取消" cancelAction:nil confirmTitle:@"確認" confirmAction:^{
         [[UIApplication sharedApplication] openURL:url];//使用浏览器打开
    }];
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
