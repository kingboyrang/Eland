//
//  IndexViewController.h
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REMenu.h"
@interface IndexViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) REMenu *menu;
@end
