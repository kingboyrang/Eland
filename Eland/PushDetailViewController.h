//
//  PushDetailViewController.h
//  Eland
//
//  Created by aJia on 13/10/9.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushResult.h"
#import "ServiceHelper.h"
@interface PushDetailViewController : BasicViewController{
    ServiceHelper *_helper;
}
-(void)loadPushDetail:(NSString*)guid;
@property(nonatomic,strong) PushResult *Entity;
@end
