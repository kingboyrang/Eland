//
//  MainViewController.h
//  active
//
//  Created by 徐 军 on 13-8-20.
//  Copyright (c) 2013年 chenjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MainViewController : UITabBarController<UINavigationControllerDelegate>{
@private
    UIView *_tabbarView;
    UIImageView *_silderView;
    int _prevSelectIndex;
    int _barButtonItemCount;
}
//是否隐藏tabbar
- (void)showTabbar:(BOOL)show;
- (void)setSelectedItemIndex:(int)index;
@end
