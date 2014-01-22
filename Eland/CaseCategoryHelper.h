//
//  CaseCategoryHelper.h
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaseCategory.h"
@interface CaseCategoryHelper : NSObject
@property(nonatomic,strong) NSMutableArray *categorys;
-(NSMutableArray*)fillTreeNodes;
-(NSMutableArray*)childsTreeNodes:(NSString*)parent;
-(NSMutableArray*)childsObjectTreeNodes:(NSMutableArray*)source Level:(int)level;

-(NSMutableArray*)childsTreeNodesWithEmpty:(NSString*)parent;
-(NSMutableArray*)getTrees;

-(NSMutableArray*)sourceTreeNodes;
+(NSString*)getCategoryName:(NSString*)guid;
//获取父类别
+(CaseCategory*)getCaseCategoryEntity:(NSString*)guid;
-(NSString*)getParentCategoryName:(NSString*)guid;
+(NSString*)getParentCategoryName:(NSString*)guid withArray:(NSArray*)arr;
//子类别
-(CaseCategory*)getCaseCategoryWithGuid:(NSString*)guid;
-(NSMutableArray*)fillCategoryTreeNodes:(NSString*)parent;

//取得子元素集合 
+(NSArray*)findByChilds:(NSString*)parent;
//取得户政府预约第一个子类别
+(CaseCategory*)getHRFirstChildWithGuid:(NSString*)guid;
//是否有子元素
+(BOOL)hasChildWithGuid:(NSString*)guid;
@end
