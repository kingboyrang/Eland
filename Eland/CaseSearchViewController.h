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
@interface CaseSearchViewController : UIViewController<PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
  @private
    PullingRefreshTableView *_tableView;
}
@property (nonatomic) BOOL refreshing;
@property (nonatomic,strong) NSMutableArray *list;
-(void)relayout:(BOOL)isLand;
-(void)loadingSource;
-(void)showAlterViewPassword:(LevelCase*)entity success:(void (^)(void))completed;
@end
