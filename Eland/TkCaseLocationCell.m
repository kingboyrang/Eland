//
//  TkCaseLocationCell.m
//  Eland
//
//  Created by aJia on 13/10/18.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TkCaseLocationCell.h"
#import "CLLocationManager+blocks.h"
@interface TkCaseLocationCell ()
@property (nonatomic, strong) CLLocationManager *manager;
-(void)buttonLocationClick;
@end

@implementation TkCaseLocationCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    UIImage *leftImage=[UIImage imageNamed:@"btn.png"];
    UIEdgeInsets leftInsets = UIEdgeInsetsMake(5,10, 5, 10);
    leftImage=[leftImage resizableImageWithCapInsets:leftInsets resizingMode:UIImageResizingModeStretch];
    
    _button=[[UIButton alloc] initWithFrame:CGRectMake(10, 4.5, 90, 35)];
    [_button setBackgroundImage:leftImage forState:UIControlStateNormal];
    _button.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button setTitle:@"定位" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonLocationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_button];
    
    self.manager=[CLLocationManager updateManager];
    self.manager.updateAccuracyFilter = kCLUpdateAccuracyFilterNone;
    self.manager.updateLocationAgeFilter = kCLLocationAgeFilterNone;
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGRect r=self.label.frame;
    r.origin.y=(self.bounds.size.height-r.size.height)/2.0;
    self.label.frame=r;
    
    
    CGRect frame=_button.frame;
    frame.origin.x=self.label.frame.origin.x+self.label.frame.size.width+5;
    frame.origin.y=(self.bounds.size.height-frame.size.height)/2.0;
    _button.frame=frame;
    
    if (frame.origin.x+frame.size.width>self.bounds.size.width) {
        
        frame.origin.x=self.bounds.size.width-frame.size.width-10;
        _button.frame=frame;
       
        r.size.width=frame.origin.x-r.origin.x-2;
        r.origin.y=(self.frame.size.height-r.size.height)/2.0;
        self.label.frame=r;
    }
    
    
}
//定位
-(void)buttonLocationClick{
    if (isLoading){return;}
    //判断定位是否启用
    if (![CLLocationManager isLocationUpdatesAvailable]) {
        [AlertHelper initWithTitle:@"提示" message:@"定位未開啓，請在設置->隱私->定位服務->施政互動啓用!"];
        return;
    }
    isLoading=YES;
    [ZAActivityBar showWithStatus:@"正在定位..." forAction:@"caselocation"];

    [self.manager startUpdatingLocationWithUpdateBlock:^(CLLocationManager *manager, CLLocation *location, NSError *error, BOOL *stopUpdating) {
        if (error) {
            [ZAActivityBar showErrorWithStatus:@"定位失敗!" forAction:@"caselocation"];
            isLoading=NO;
        }else{
            [ZAActivityBar showSuccessWithStatus:@"定位成功!" forAction:@"caselocation"];
            isLoading=NO;
            if (self.controller&&[self.controller respondsToSelector:@selector(finishedLocation:)]) {
                [self.controller performSelector:@selector(finishedLocation:) withObject:location];
            }
        }
        *stopUpdating = YES;
    }];
}
@end
