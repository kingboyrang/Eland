//
//  CaseCategoryHelper.h
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseCategoryHelper : NSObject
@property(nonatomic,strong) NSMutableArray *categorys;
-(NSMutableArray*)fillTreeNodes;
-(NSMutableArray*)childsTreeNodes:(NSString*)parent;
-(NSMutableArray*)childsObjectTreeNodes:(NSMutableArray*)source Level:(int)level;

-(NSMutableArray*)sourceTreeNodes;
+(NSString*)getCategoryName:(NSString*)guid;
@end
