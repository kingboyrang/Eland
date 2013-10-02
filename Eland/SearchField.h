//
//  SearchField.h
//  Eland
//
//  Created by aJia on 13/10/2.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchField : UIView<UITableViewDataSource,UITableViewDelegate>{
@private
    UITableView *_tableView;
}
@property (nonatomic,strong) NSMutableArray *cells;
@end
