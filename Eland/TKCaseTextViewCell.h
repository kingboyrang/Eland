//
//  TKCaseTextViewCell.h
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPlaceholderTextView.h"
#import "SVPlacemark.h"
@interface TKCaseTextViewCell : UITableViewCell{
    CGFloat _cornerRadio;
	UIColor *_borderColor;
	CGFloat _borderWidth;
	UIColor *_lightColor;
	CGFloat _lightSize;
	UIColor *_lightBorderColor;
}
@property (nonatomic,strong) GCPlaceholderTextView *textView;
@property(nonatomic,readonly) BOOL hasValue;
@property(nonatomic,assign) BOOL required;
@property(nonatomic,copy) NSString *LabelName;
@property(nonatomic,assign) id delegate;
- (void)errorVerify;
- (void)errorVerify:(CGFloat)radio
		borderColor:(UIColor*)bColor
		borderWidth:(CGFloat)bWidth
		 lightColor:(UIColor*)lColor
		  lightSize:(CGFloat)lSize
   lightBorderColor:(UIColor*)lbColor;
- (void)removeVerify;
- (void)exitKeyboard;

-(void)finishedLocation:(CLLocation*)location;
@end
