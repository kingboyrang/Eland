//
//  PushViewController.h
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) NSMutableArray *listData;
-(void)relayout:(BOOL)isLand;
@end
