//
//  SearchField.h
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "CVUIPopoverText.h"
#import "CaseCity.h"
#import "CaseCategory.h"
#import "LevelCaseArgs.h"
@interface SearchField : UIView<UITableViewDataSource,UITableViewDelegate,CVUIPopoverTextDelegate,FPPopoverControllerDelegate>{
@private
    UITableView *_tableView;
    FPPopoverController *popoverCity;
    FPPopoverController *popoverCategory;
}
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong) LevelCaseArgs *levevlCaseArgs;
@property (nonatomic,readonly) NSString *searchArgs;
-(void)hidePopoverCity;
-(void)selectedVillageTown:(CaseCity*)city;
-(void)selectedCaseCategory:(CaseCategory*)category;
@end
