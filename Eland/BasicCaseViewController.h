//
//  BasicCaseViewController.h
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "CaseSetting.h"
@interface BasicCaseViewController : BasicViewController{
@private
    FPPopoverController *popoverCaseCategory;
    FPPopoverController *popoverCaseCity;
}
-(NSMutableArray*)CaseCategoryAndCityCells:(CaseSetting*)entity;
//注意事项
-(NSMutableArray*)CaseCategoryNoteCells:(CaseSettingField*)entity;
//多行文本操作
-(NSMutableArray*)CaseCategoryTextAreaCells:(CaseSettingField*)entity;
//单行文本操作
-(NSMutableArray*)CaseCategoryTextCells:(CaseSettingField*)entity;
//案件图片
-(NSMutableArray*)CaseCategoryImagesCells:(CaseSetting*)entity;

-(void)buttonCaseCategoryClick:(id)sender CaseCategoryGUID:(NSString*)guid;
-(void)hidePopoverCaseCategory;
-(void)buttonCaseCityClick:(id)sender;
-(void)hidePopoverCaseCity;
@end