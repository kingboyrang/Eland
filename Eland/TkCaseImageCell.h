//
//  TkCaseImageCell.h
//  Eland
//
//  Created by aJia on 13/10/18.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCaseLabelTextFieldCell.h"
#import "MKPhotoScroll.h"
#import "TKEmptyView.h"
@interface TkCaseImageCell : UITableViewCell<CaseImageSelectDelegate,MKPhotoScrollDelegate>{
    
}
@property(nonatomic,copy) NSString *UpImgNum;
@property(nonatomic,strong) MKPhotoScroll *PhotoScroll;
@property(nonatomic,strong) TKEmptyView *emptyView;
@property(nonatomic,assign) UIViewController *showInController;
@end
