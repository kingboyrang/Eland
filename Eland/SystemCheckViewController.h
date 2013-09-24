//
//  SystemCheckViewController.h
//  Eland
//
//  Created by aJia on 13/9/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemCheckViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *checkcells;
@property (nonatomic,strong) NSMutableArray *gpscells;
@end
