//
//  IndexViewController.h
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepairItemViewController.h"
#import "CaseSearchViewController.h"
#import "PushViewController.h"
#import "BusinessAreaViewController.h"
#import "PagerViewController.h"
@interface IndexViewController : PagerViewController{
    /**@private
    RepairItemViewController *_repair;
    CaseSearchViewController *_caseSearch;
    PushViewController *_push;
    BusinessAreaViewController *_business;
    UIViewController *_currentViewController;
     ***/
}
-(void)selectedMenuItemIndex:(int)index;
//- (void)handChangePageIndex:(int)index;
@end
