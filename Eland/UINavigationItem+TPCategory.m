//
//  UINavigationItem+CustomNavigationItem.m
//  CaseSearch
//
//  Created by aJia on 12/12/9.
//  Copyright (c) 2012年 rang. All rights reserved.
//

#import "UINavigationItem+TPCategory.h"
#import "UIImage+TPCategory.h"
#import "FXLabel.h"
#import "NSString+TPCategory.h"
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
-(void)setShadowTitle:(NSString*)title
{
    CGSize size=[title textSize:[UIFont fontWithName:@"Helvetica-Bold" size:20] withWidth:DeviceWidth];
    FXLabel *secondLabel = [[FXLabel alloc] init];
    secondLabel.frame = CGRectMake((DeviceWidth-size.width)/2.0,(44-size.height)/2.0, size.width, 44);
    secondLabel.backgroundColor = [UIColor clearColor];
    secondLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    secondLabel.text = title;
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.textColor = [UIColor whiteColor];
    secondLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.75f];
    secondLabel.shadowOffset = CGSizeMake(0.0f, 5.0f);
    secondLabel.shadowBlur = 5.0f;
    self.titleView=secondLabel;
    [secondLabel release];
    
}
@end
