//
//  UserSetViewController.h
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSetViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property(nonatomic,retain) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cells;
@end
