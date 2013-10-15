//
//  CaseDetailViewController.h
//  Eland
//
//  Created by aJia on 13/10/7.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelCase.h"
#import "ServiceHelper.h"
#import "CaseSetting.h"
#import "Case.h"
#import "MKPhotoScroll.h"
@interface CaseDetailViewController : BasicViewController<MKPhotoScrollDelegate,UITableViewDataSource,UITableViewDelegate>{
@private
    ServiceHelper *_serviceHelper;
    UITableView *_tableView;
    
}
@property(nonatomic,strong) LevelCase *itemCase;
@property(nonatomic,strong) Case *entityCase;
@property(nonatomic,strong) CaseSetting *entityCaseSetting;
@property(nonatomic,strong) NSMutableArray *cells;
//@property(nonatomic,strong) NSMutableArray *cellHeights;
@end
