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
//案件瀏覽密码
-(NSMutableArray*)CaseCategoryPWDCells;
//位置描述
-(NSMutableArray*)CaseCategoryLocationCells:(CaseSettingField*)entity;
//路灯编号
-(NSMutableArray*)CaseCategoryNumberCells:(CaseSettingField*)entity;
-(NSMutableArray*)CaseCategoryLightNumberCells:(CaseSettingField*)entity;
//走失时间 
-(NSMutableArray*)CaseCategoryLostDateCells:(CaseSettingField*)entity;
//单选
-(NSMutableArray*)CaseCategoryRadioCells:(CaseSettingField*)entity;
//1,出生登记,2结婚登记,3，死亡登记
-(NSMutableArray*)CaseCategoryHRCells:(CaseSetting*)entity hrType:(int)type;
//年龄==>下拉选单
-(NSMutableArray*)CaseCategoryDropCells:(CaseSettingField*)entity;

-(void)buttonCaseCategoryClick:(id)sender CaseCategoryGUID:(NSString*)guid;
-(void)hidePopoverCaseCategory;
-(void)buttonCaseCityClick:(id)sender;
-(void)hidePopoverCaseCity;


@end
