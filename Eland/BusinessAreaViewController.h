//
//  BusinessAreaViewController.h
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
@interface BusinessAreaViewController : BasicViewController<ServiceHelperDelegate,UITableViewDataSource,UITableViewDelegate>{
    ServiceHelper *_serviceHelper;
}
@property(nonatomic,retain) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cells;
-(void)relayout:(BOOL)isLand;
@end
