//
//  TkCaseLocationCell.h
//  Eland
//
//  Created by aJia on 13/10/18.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseLabelCell.h"

@interface TkCaseLocationCell : TKCaseLabelCell{
    BOOL isLoading;
}
@property(nonatomic,strong) UIButton *button;
@property(nonatomic,assign) id controller;
@end
