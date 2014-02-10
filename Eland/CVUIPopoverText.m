//
//  CVUIPopoverText.m
//  CalendarDemo
//
//  Created by rang on 13-3-12.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CVUIPopoverText.h"

@interface CVUIPopoverText ()
-(void)buttonChooseClick:(id)sender;
@end

@implementation CVUIPopoverText
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //文本框显示日期
        _popoverTextField=[[UITextField alloc] initWithFrame:self.bounds];
        //self.popoverTextField.borderStyle=UITextBorderStyleRoundedRect;
        _popoverTextField.placeholder=@"請選擇";
        _popoverTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//設定本文垂直置中
        _popoverTextField.enabled=NO;//设置不可以编辑
        _popoverTextField.font=[UIFont systemFontOfSize:14];
        [self addSubview:_popoverTextField];
        //设置按钮
        _buttonTap=[UIButton buttonWithType:UIButtonTypeCustom];
        _buttonTap.frame=self.bounds;
        [_buttonTap addTarget:self action:@selector(buttonChooseClick:) forControlEvents:UIControlEventTouchUpInside];
       
        [self addSubview:_buttonTap];

    }
    return self;
}
- (void)resetEventTap{
    if ([_buttonTap respondsToSelector:@selector(buttonChooseClick:)]) {
        NSLog(@"Yes===");
    }
 //[_buttonTap removeTarget:self action:@selector(buttonChooseClick:) forControlEvents:UIControlEventTouchUpInside];
 //[_buttonTap addTarget:self action:@selector(buttonChooseClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void) layoutSubviews{
    [super layoutSubviews];
    CGRect frame=self.frame;
    frame.origin.x=0;
    frame.origin.y=0;
    _popoverTextField.frame=frame;
    _buttonTap.frame=frame;
}
-(void)buttonChooseClick:(id)sender{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(doneShowPopoverView:senderView:)]) {
        [self.delegate doneShowPopoverView:self senderView:sender];
    }
}
@end
