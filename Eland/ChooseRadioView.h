//
//  ChooseRadioView.h
//  Eland
//
//  Created by aJia on 2013/11/28.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseRadioView : UIView{
@private
    
    UILabel *_lightLabel;
    UILabel *_addressLabel;
    
}
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,readonly) NSString *radioValue;
-(void)setSelectedIndex:(int)index;
-(void)setIndexWithTitle:(NSString*)title withIndex:(int)index;
@end
