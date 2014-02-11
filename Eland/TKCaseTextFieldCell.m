//
//  TKCaseTextFieldCell.m
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseTextFieldCell.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+TPCategory.h"
@interface TKCaseTextFieldCell ()
- (void)endEditing:(NSNotification*)notification;
@end
@implementation TKCaseTextFieldCell
@synthesize hasValue;
@synthesize required;
-(void)dealloc{
    [super dealloc];
    if(_borderColor){
        [_borderColor release],_borderColor=nil;
    }
    if(_lightColor){
        [_lightColor release],_lightColor=nil;
    }
    if(_lightBorderColor){
        [_lightBorderColor release],_lightBorderColor=nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    
    _field = [[UITextField alloc] initWithFrame:CGRectZero];
	_field.borderStyle=UITextBorderStyleRoundedRect;
    _field.textAlignment = NSTextAlignmentLeft;
    _field.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    _field.font = [UIFont boldSystemFontOfSize:16.0];
    _field.delegate=self;
	[self.contentView addSubview:_field];
    
    _cornerRadio=5.0;
    _borderColor=[[UIColor colorWithCGColor:_field.layer.borderColor] retain];
    _borderWidth=_field.layer.borderWidth;
    _lightColor=[[UIColor redColor] retain];
    _lightSize=8.0;
    _lightBorderColor=[[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] retain];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextFieldTextDidEndEditingNotification object:_field];

    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect r=CGRectInset(self.bounds, 10, 4);
	[self.field setFrame:r];
}
#pragma mark UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
	[_field resignFirstResponder];
    if (self.required) {
        if (self.hasValue) {
            [self removeVerify];
        }else{
            [self errorVerify];
        }
    }
    return NO;
}
- (void)endEditing:(NSNotification*)notification
{
    if (self.required) {
        if (self.hasValue) {
            [self removeVerify];
        }else{
            [self errorVerify];
        }
    }
}
- (CGRect)textRectForBounds:(CGRect)bounds
{
	CGRect inset = CGRectMake(bounds.origin.x + _cornerRadio*2,
							  bounds.origin.y,
							  bounds.size.width - _cornerRadio*2,
							  bounds.size.height);
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
	CGRect inset = CGRectMake(bounds.origin.x + _cornerRadio*2,
							  bounds.origin.y,
							  bounds.size.width - _cornerRadio*2,
							  bounds.size.height);
    return inset;
}
#pragma mark public methods
-(BOOL)hasValue{
    NSString *str=[self.field.text Trim];
    if ([str length]>0) {
        return YES;
    }
    return NO;
}
- (void)errorVerify{
    [self.field.layer setCornerRadius:_cornerRadio];
    [self.field.layer setBorderColor:_borderColor.CGColor];
    [self.field.layer setBorderWidth:_borderWidth];
    [self.field.layer setMasksToBounds:NO];
    //设置阴影
    [[self.field layer] setShadowOffset:CGSizeMake(0, 0)];
    [[self.field layer] setShadowRadius:_lightSize];
    [[self.field layer] setShadowOpacity:1];
    [[self.field layer] setShadowColor:_lightColor.CGColor];
	[self.field.layer setBorderColor:_lightBorderColor.CGColor];
}
- (void)errorVerify:(CGFloat)radio
		borderColor:(UIColor*)bColor
		borderWidth:(CGFloat)bWidth
		 lightColor:(UIColor*)lColor
		  lightSize:(CGFloat)lSize
   lightBorderColor:(UIColor*)lbColor{
    if (_borderColor!=bColor) {
        [_borderColor release];
        _borderColor = [bColor retain];
    }
    _cornerRadio = radio;
    _borderWidth = bWidth;
    if (_lightColor!=lColor) {
        [_lightColor release];
        _lightColor = [lColor retain];
    }
    _lightSize = lSize;
    if (_lightBorderColor!=lbColor) {
        [_lightBorderColor release];
        _lightBorderColor = [lbColor retain];
    }
    [self errorVerify];
}
- (void)removeVerify{
    [[self.field layer] setShadowOffset:CGSizeZero];
    [[self.field layer] setShadowRadius:0];
    [[self.field layer] setShadowOpacity:0];
    [[self.field layer] setShadowColor:nil];
	[self.field.layer setBorderColor:_borderColor.CGColor];
}
@end
