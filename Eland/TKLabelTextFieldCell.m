//
//  TKLabelTextfieldCell.m
//  Created by Devin Ross on 7/1/09.
//
/*
 
 tapku.com || http://github.com/devinross/tapkulibrary
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "TKLabelTextFieldCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation TKLabelTextFieldCell
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
    
    _field = [[EMKeyboardBarTextField alloc] initWithFrame:CGRectZero];
	_field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	_field.backgroundColor = [UIColor clearColor];
    _field.font = [UIFont boldSystemFontOfSize:16.0];
    _field.delegate = self;
    [self.contentView addSubview:_field];
    
    /***
    _cornerRadio=5.0;
    _borderColor=[[UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1] retain];
    _borderWidth=_field.layer.borderWidth;
    _lightColor=[[UIColor colorWithRed:243/255.0 green:168/255.0 blue:51/255.0 alpha:1] retain];
    _lightSize=8.0;
    _lightBorderColor=[[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] retain];
     ***/
    
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
	
	CGRect r = CGRectInset(self.contentView.bounds, 8, 8);
	r.origin.x += self.label.frame.size.width + 6;
	r.size.width -= self.label.frame.size.width + 6;
	_field.frame = r;
	
	
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
- (void)endEditing:(NSNotification*) notification
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
    NSString *str=[self Trim:self.field.text];
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
