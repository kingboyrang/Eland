//
//  VillageTownViewController.h
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface VillageTownViewController : UIViewController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>{
@private
    int currentIndex;
    UITableView *_tableView;
    MBProgressHUD *HUD;
}
@property(nonatomic,retain) NSArray *listData;
@property(nonatomic,assign) id delegate;
@property(nonatomic,assign) BOOL showAll;//是否显示全部
@end
