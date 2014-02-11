//
//  TKCaseTextViewCell.m
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseTextViewCell.h"
#import "NSString+TPCategory.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+TPCategory.h"
@implementation TKCaseTextViewCell
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
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _textView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectZero];
	_textView.contentInset = UIEdgeInsetsZero;
    _textView.textColor=[UIColor blackColor];
    _textView.font = [UIFont boldSystemFontOfSize:16.0];
    _textView.layer.borderWidth=2.0;
    _textView.layer.cornerRadius=5.0;
    _textView.layer.borderColor=[UIColor colorFromHexRGB:@"959595"].CGColor;
    //_textView.controller=self;
    [self.contentView addSubview:_textView];
    
    _cornerRadio=5.0;
    _borderColor=[[UIColor colorWithCGColor:_textView.layer.borderColor] retain];
    _borderWidth=_textView.layer.borderWidth;
    _lightColor=[[UIColor redColor] retain];
    _lightSize=8.0;
    _lightBorderColor=[[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] retain];
	
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];

    CGRect r=CGRectInset(self.bounds, 10, 4);
    r.size.height=112;
	[self.textView setFrame:r];
    
}
/**
- (void)exitKeyboard{
    if (self.required) {
        if (self.hasValue) {
            [self removeVerify];
        }else{
            [self errorVerify];
        }
    }
}
 ***/
-(BOOL)hasValue{
    NSString *str=[self.textView.text Trim];
    if ([str length]>0) {
        return YES;
    }
    return NO;
}
- (void)errorVerify{
    [self.textView.layer setCornerRadius:_cornerRadio];
    [self.textView.layer setBorderColor:_borderColor.CGColor];
    [self.textView.layer setBorderWidth:_borderWidth];
    [self.textView.layer setMasksToBounds:NO];
    //设置阴影
    [[self.textView layer] setShadowOffset:CGSizeMake(0, 0)];
    [[self.textView layer] setShadowRadius:_lightSize];
    [[self.textView layer] setShadowOpacity:1];
    [[self.textView layer] setShadowColor:_lightColor.CGColor];
	[self.textView.layer setBorderColor:_lightBorderColor.CGColor];
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
    [[self.textView layer] setShadowOffset:CGSizeZero];
    [[self.textView layer] setShadowRadius:0];
    [[self.textView layer] setShadowOpacity:0];
    [[self.textView layer] setShadowColor:nil];
	[self.textView.layer setBorderColor:_borderColor.CGColor];
}
-(void)finishedLocation:(SVPlacemark*)place{
    self.textView.text=place.formattedAddress;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(geographyLocation:)]) {
        [self.delegate performSelector:@selector(geographyLocation:) withObject:place];
    }
}
@end
