//
//  IndexViewController.h
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REMenu.h"
@class RepairItemViewController;
@class CaseSearchViewController;
@class PushViewController;
@class BusinessAreaViewController;
@interface IndexViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>{
@private
    RepairItemViewController *_repairItem;
    CaseSearchViewController *_casesearch;
    PushViewController *_push;
    BusinessAreaViewController *_businessarea;
    UIViewController  *_currentViewController;
}
@property (strong, nonatomic) REMenu *menu;
-(void)reSubViewLayout;
@end
