//
//  ShakeView.m
//  Eland
//
//  Created by aJia on 13/10/22.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "ShakeView.h"
#import "NSString+TPCategory.h"
#import "UIColor+TPCategory.h"
#import "LinearImage.h"
#import <QuartzCore/QuartzCore.h>

@interface ShakeView ()
-(void)buttonCancelClick;
-(void)buttonDoneClick;
-(void)exitKeyboard;
@end

@implementation ShakeView
@synthesize delegated;
-(void)dealloc{
    [super dealloc];
    [_bgView release],_bgView=nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth=2.0;
        self.layer.borderColor=[UIColor whiteColor].CGColor;
        self.layer.cornerRadius=5.0;
        self.layer.masksToBounds=YES;
        self.backgroundColor=[UIColor whiteColor];
        
        NSString *title=@"案件密碼";
        CGSize size=[title textSize:[UIFont boldSystemFontOfSize:16] withWidth:296];
        _label=[[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-size.width)/2.0, 7, size.width, size.height)];
        _label.font=[UIFont boldSystemFontOfSize:16];
        _label.textColor=[UIColor blackColor];
        _label.backgroundColor=[UIColor clearColor];
        _label.text=@"案件密碼";
        [self addSubview:_label];
        
        _field=[[EMKeyboardBarTextField alloc] initWithFrame:CGRectMake(7.5, 7+size.height+5, frame.size.width-14, 35)];
        _field.delegate=self;
        _field.borderStyle=UITextBorderStyleRoundedRect;
        _field.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        _field.font=[UIFont boldSystemFontOfSize:16];
        _field.secureTextEntry=YES;
        _field.placeholder=@"請輸入案件密碼";
        [_field addTarget:self action:@selector(exitKeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self addSubview:_field];
        
        UIImage *leftImage=[LinearImage createCornerImageSize:CGSizeMake(100, 35) cornerRadius:5.0 imageColor:[UIColor colorFromHexRGB:@"fbab09"]];
        UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame=CGRectMake((frame.size.width/2-100)/2.0, _field.frame.origin.y+_field.frame.size.height+5, 100, 35);
        [leftBtn setBackgroundImage:leftImage forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        leftBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(buttonCancelClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        
        
        UIImage *rightImage=[LinearImage createCornerImageSize:CGSizeMake(100, 35) cornerRadius:5.0 imageColor:[UIColor colorFromHexRGB:@"fbab09"]];
        UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame=CGRectMake(frame.size.width/2+(frame.size.width/2-100)/2, _field.frame.origin.y+_field.frame.size.height+5, 100, 35);
        [rightBtn setBackgroundImage:rightImage forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [rightBtn setTitle:@"確認" forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(buttonDoneClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        
        CGRect  ScreenRect=[[UIScreen mainScreen] bounds];
        CGRect rect=self.frame;
        rect.size.height=rightBtn.frame.origin.y+rightBtn.frame.size.height+7;
        rect.origin.y=-rect.size.height;
        rect.origin.x=(ScreenRect.size.width-rect.size.width)/2.0;
        self.frame=rect;
        
       
        _bgView=[[UIView alloc] initWithFrame:ScreenRect];
        _bgView.backgroundColor=[UIColor grayColor];
        _bgView.alpha=0.9;
        
    }
    return self;
}
-(void)exitKeyboard{
   [_field resignFirstResponder];
}
-(void)buttonCancelClick{
    [self hide:nil];
}
-(void)buttonDoneClick{
    if (self.Entity&&[self.Entity.PWD length]>0&&[self.field.text isEqualToString:self.Entity.PWD]) {
        [self hide:^{
            if (self.delegated&&[self.delegated respondsToSelector:@selector(showSuccessPassword:)]) {
                [self.delegated performSelector:@selector(showSuccessPassword:) withObject:self.Entity];
            }
        }];
    }else{
        [self.field shake];
    }
}
-(void)show{
    _field.text=@"";
   CGRect rect=[[UIScreen mainScreen] bounds];
    [_bgView addSubview:self];
    UIWindow *window=[[UIApplication sharedApplication] keyWindow];
    [window addSubview:_bgView];
    CGRect r=self.frame;
    r.origin.y=(rect.size.height-r.size.height)/2-30;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.frame=r;
    }];
}
-(void)hide:(void(^)())completed{
    CGRect r=self.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.frame=r;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            [_bgView removeFromSuperview];
            if (completed) {
                completed();
            }
        }
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
