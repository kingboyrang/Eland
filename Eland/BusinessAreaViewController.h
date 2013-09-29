//
//  BusinessAreaViewController.h
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessAreaViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cells;
@end
