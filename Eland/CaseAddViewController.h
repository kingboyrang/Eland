//
//  CaseAddViewController.h
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaseSetting.h"
#import "BasicCaseViewController.h"
#import "CaseCategory.h"
#import "CaseCity.h"
#import "SVPlacemark.h"
#import "Case.h"
@interface CaseAddViewController : BasicCaseViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    Case *_caseArgs;
    int  _hrType;
}
@property(nonatomic,strong) CaseSetting *Entity;
@property(nonatomic,strong) NSMutableArray *cells;
//案件分类
-(void)selectedCaseCategory:(CaseCategory*)category;
//鄉鎮市別
-(void)selectedVillageTown:(CaseCity*)city;
//取得经纬度
-(void)geographyLocation:(SVPlacemark*)place;
//路灯编号与地址之间的切换
-(void)switchControlSelectedIndex:(NSInteger)index withObject:(id)sender;
@end
