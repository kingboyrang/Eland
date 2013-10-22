//
//  ShakeView.h
//  Eland
//
//  Created by aJia on 13/10/22.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMKeyboardBarTextField.h"
#import "LevelCase.h"
@interface ShakeView : UIView<UITextFieldDelegate>{
    UIView *_bgView;
}
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) EMKeyboardBarTextField *field;
@property(nonatomic,strong) LevelCase *Entity;
@property(nonatomic,assign) id delegated;
-(void)show;
-(void)hide:(void(^)())completed;
@end
