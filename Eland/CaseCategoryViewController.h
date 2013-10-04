//
//  CaseCategoryViewController.h
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface CaseCategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>{
   MBProgressHUD *HUD;
}
@property (nonatomic, retain) NSMutableArray *displayArray;
@property(nonatomic,assign) id delegate;
@end
