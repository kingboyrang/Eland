//
//  CaseSearchViewController.h
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "LevelCaseArgs.h"
#import "LevelCase.h"
#import "ASIFormDataRequest.h"
#import "ShakeView.h"
@interface CaseSearchViewController : BasicViewController<PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
  @private
    PullingRefreshTableView *_tableView;
    ShakeView *_shakeView;
}
@property(nonatomic,strong) UINavigationController *parentNavigation;
@property(nonatomic,strong) ASIFormDataRequest *helper;
@property (nonatomic) BOOL refreshing;
@property (nonatomic,strong) NSMutableArray *list;
-(void)relayout:(BOOL)isLand;
-(void)loadingSource;
-(void)showAlterViewPassword:(LevelCase*)entity success:(void (^)(void))completed;
-(void)showSuccessPassword:(LevelCase*)entity;
@end
