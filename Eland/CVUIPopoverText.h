//
//  CVUIPopoverText.h
//  CalendarDemo
//
//  Created by rang on 13-3-12.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CVUIPopoverTextDelegate <NSObject>
@optional
-(void)doneShowPopoverView:(id)sender senderView:(id)view;
@end

@interface CVUIPopoverText : UIView

@property(nonatomic,retain) UITextField *popoverTextField;
@property(nonatomic,retain)  UIButton *buttonTap;
@property(nonatomic,assign) id<CVUIPopoverTextDelegate> delegate;
- (void)resetEventTap;
@end
