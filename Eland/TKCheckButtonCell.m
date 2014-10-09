//
//  TKCheckButtonCell.m
//  Eland
//
//  Created by aJia on 13/10/9.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCheckButtonCell.h"
#import "UIColor+TPCategory.h"
#import "LocationGPS.h"
@implementation TKCheckButtonCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _label=[[UILabel alloc] initWithFrame:CGRectZero];
    _label.font=[UIFont boldSystemFontOfSize:16];
    _label.textColor=[UIColor colorFromHexRGB:@"666666"];
    _label.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:_label];
    
    UIImage *leftImage=[UIImage imageNamed:@"btn.png"];
    UIEdgeInsets leftInsets = UIEdgeInsetsMake(5,10, 5, 10);
    leftImage=[leftImage resizableImageWithCapInsets:leftInsets resizingMode:UIImageResizingModeStretch];
    
    _button=[[UIButton alloc] initWithFrame:CGRectMake(10, 0, 70, 40)];
    [_button setBackgroundImage:leftImage forState:UIControlStateNormal];
    _button.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_button];
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}

-(void)startLocation:(void(^)(BOOL finished))completed{
    if (isLoading){return;}
    isLoading=YES;
    [ZAActivityBar showWithStatus:@"正在定位..." forAction:@"checklocation"];

    LocationGPS *gps=[[LocationGPS alloc] init];
    [gps startLocation:^(CLPlacemark *place) {
        [ZAActivityBar showSuccessWithStatus:@"定位成功!" forAction:@"checklocation"];
        _label.text=[NSString stringWithFormat:@"%f~%f",place.location.coordinate.longitude,place.location.coordinate.latitude];
        _label.textColor=[UIColor redColor];
        isLoading=NO;
        if (completed) {
            completed(YES);
        }
        
    } failed:^(NSError *error) {
        [ZAActivityBar showErrorWithStatus:@"定位失敗!" forAction:@"checklocation"];
        isLoading=NO;
        _label.textColor=[UIColor colorFromHexRGB:@"666666"];
        if (completed) {
            completed(NO);
        }
    }];
    
}
- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect frame=[_button frame];
    frame.origin.y=(self.bounds.size.height-frame.size.height)/2.0;
    _button.frame=frame;
    
    frame=_label.frame;
    frame.origin.x=_button.frame.size.width+_button.frame.origin.x+5;
    frame.origin.y=_button.frame.origin.y;
    frame.size.width=self.frame.size.width-frame.origin.x;
    frame.size.height=_button.frame.size.height;
    _label.frame=frame;
}
@end
