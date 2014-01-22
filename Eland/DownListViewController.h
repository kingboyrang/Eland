//
//  DownListViewController.h
//  Eland
//
//  Created by aJia on 2014/1/21.
//  Copyright (c) 2014年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CaseCategory.h"
@interface DownListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}
@property (nonatomic, retain) NSMutableArray *list;
@property(nonatomic,assign) id delegate;
@property(nonatomic,assign) id popoverControl;
@property(nonatomic,assign) BOOL defaultLoad;
@property(nonatomic,copy) NSString *ParentGUID;
- (void)setSelectedCategoryIndex:(int)index;
- (void)resetDataSourceWithParentGuid:(NSString*)guid;
@end
