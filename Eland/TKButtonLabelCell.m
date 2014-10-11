//
//  TKButtonLabelCell.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKButtonLabelCell.h"
#import "NSString+TPCategory.h"
#import "UIColor+TPCategory.h"
#import "ZAActivityBar.h"
#import "AlertHelper.h"
#import "CLLocationManager+blocks.h"

@interface TKButtonLabelCell ()

@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation TKButtonLabelCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame=CGRectMake(10, 0, 100, 44);
        _button.backgroundColor=[UIColor clearColor];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    _button.titleLabel.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:_button];
        
        _label=[[UILabel alloc] initWithFrame:CGRectZero];
        _label.font=[UIFont boldSystemFontOfSize:16];
        _label.textColor=[UIColor redColor];
        _label.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_label];
    
    self.manager=[CLLocationManager updateManager];
    self.manager.updateAccuracyFilter = kCLUpdateAccuracyFilterNone;
    self.manager.updateLocationAgeFilter = kCLLocationAgeFilterNone;
    
    return self;
}

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
-(void)setLabelValue:(NSString*)title normal:(BOOL)isNormal
{
    if (isNormal) {
        _label.textColor=[UIColor colorFromHexRGB:@"666666"];
    }
    _label.text=title;
    
}
BOOL isLoading=NO;
-(void)startLocation{
    if (isLoading){return;}
    //判断定位是否启用
    if (![CLLocationManager isLocationUpdatesAvailable]) {
        [AlertHelper initWithTitle:@"提示" message:@"定位未開啓，請在設置->隱私->定位服務->施政互動啓用!"];
        return;
    }
    isLoading=YES;
    [ZAActivityBar showWithStatus:@"正在定位..." forAction:@"checklocation"];

    [self.manager startUpdatingLocationWithUpdateBlock:^(CLLocationManager *manager, CLLocation *location, NSError *error, BOOL *stopUpdating) {
        if (error) {
            [ZAActivityBar showErrorWithStatus:@"定位失敗!" forAction:@"checklocation"];
            isLoading=NO;
        }else{
            [ZAActivityBar showSuccessWithStatus:@"定位成功!" forAction:@"checklocation"];
            _label.text=[NSString stringWithFormat:@"%f~%f",location.coordinate.longitude,location.coordinate.latitude];
            isLoading=NO;
        }
        *stopUpdating = YES;
    }];

}
- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGSize size=[_button.titleLabel.text textSize:[UIFont boldSystemFontOfSize:16] withWidth:self.bounds.size.width];
    CGRect frame=_button.frame;
    if (size.width>frame.size.width) {
        frame.size.width=size.width;
        _button.frame=frame;
    }

    CGRect r = CGRectInset(self.contentView.bounds, 8, 8);
	r.origin.x += self.button.frame.size.width + 6;
	r.size.width -= self.button.frame.size.width + 6;
	_label.frame = r;
   
	    
}
@end
