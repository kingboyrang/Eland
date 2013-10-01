//
//  MenuSegment.h
//  Eland
//
//  Created by aJia on 13/10/1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuBar : UIView<UIScrollViewDelegate>{
@private
    UIScrollView *_scrollView;
    int _prevSelectedIndex;
}
@property(nonatomic,readonly) int selectedIndex;
-(void)setSelectedItemIndex:(int)index;
@end
