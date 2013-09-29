//
//  UINavigationItem+CustomNavigationItem.m
//  CaseSearch
//
//  Created by aJia on 12/12/9.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "UINavigationItem+TPCategory.h"
#import "UIImage+TPCategory.h"
@implementation UINavigationItem (TPCategory)
-(void)titleViewBackground{
    
    
    CGFloat w=(256*44)/67;
    CGFloat leftx=(320-w)/2.0;
    
     UIImage *logoImage=[[UIImage imageNamed:@"logo.png"] imageByScalingProportionallyToSize:CGSizeMake(w, 44)];
    UIImageView *logoView=[[UIImageView alloc] initWithImage:logoImage];
    logoView.frame=CGRectMake(leftx, 0, w, 44);
    self.titleView=logoView;
    [logoView setImage:logoImage];
}
-(void)resetNavigationBarBack{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"Back";
    self.backBarButtonItem = backItem;
    [backItem release];
}
@end
