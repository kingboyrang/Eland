//
//  ScrollControls.h
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollControls : UIScrollView
@property(nonatomic,readonly) int selectedIndex;
-(void)setSelectedItemIndex:(int)index;
@end
