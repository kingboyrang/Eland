//
//  CaseCategoryHelper.m
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseCategoryHelper.h"
#import "TreeViewNode.h"
#import "CacheHelper.h"
@implementation CaseCategoryHelper
-(NSMutableArray*)sourceTreeNodes{
    CaseCategory *item=[[[CaseCategory alloc] init] autorelease];
    item.Name=@"全部";
    item.GUID=@"";
    item.Parent=@"";
    
    TreeViewNode *node=[[[TreeViewNode alloc] init] autorelease];
    node.nodeLevel = 0;
    node.nodeObject =item;
    node.isExpanded = NO;
    
    NSMutableArray *arr=[self fillTreeNodes];
    NSMutableArray *result=[NSMutableArray array];
    [result addObject:node];
    if (arr&&[arr count]>0) {
        [result addObjectsFromArray:arr];
    }
    return result;
}
-(NSMutableArray*)fillTreeNodes{
    if (self.categorys==nil||[self.categorys count]==0) {
        return nil;
    }
    NSMutableArray *source=[self childsTreeNodes:@""];
    return [self childsObjectTreeNodes:source Level:0];
}
-(NSMutableArray*)childsTreeNodes:(NSString*)parent
{
    NSString *match=[NSString stringWithFormat:@"SELF.Parent =='%@'",parent];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
    NSArray *results = [self.categorys filteredArrayUsingPredicate:predicate];
    if (results&&[results count]>0) {
        return [NSMutableArray arrayWithArray:results];
    }
    return nil;
}
-(NSMutableArray*)childsObjectTreeNodes:(NSMutableArray*)source Level:(int)level{
    if (source&&[source count]>0) {
        NSMutableArray *result=[NSMutableArray array];
        for (CaseCategory *item in source) {
            TreeViewNode *firstLevelNode1 =[[[TreeViewNode alloc] init] autorelease];
            firstLevelNode1.nodeLevel = level;
            firstLevelNode1.nodeObject =item;
            firstLevelNode1.isExpanded = NO;
            
            NSMutableArray *childs=[self childsTreeNodes:item.GUID];
            if (childs&&[childs count]>0) {
                //NSLog(@"childs=%@\n",childs);
                firstLevelNode1.nodeChildren=[self childsObjectTreeNodes:childs Level:level+1];
            }
            [result addObject:firstLevelNode1];
        }
        return result;
    }
    return nil;
}
+(NSString*)getCategoryName:(NSString*)guid{
    CaseCategory *item=[self getCaseCategoryEntity:guid];
    if (item!=nil) {
        return item.Name;
    }
   return @"";
}
+(CaseCategory*)getCaseCategoryEntity:(NSString*)guid{
    NSArray *arr=[CacheHelper readCacheCaseCategorys];
    if (arr==nil||[arr count]==0) {
        return nil;
    }
    NSString *match=[NSString stringWithFormat:@"SELF.GUID =='%@'",guid];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
    NSArray *results = [arr filteredArrayUsingPredicate:predicate];
    if (results&&[results count]>0) {
        CaseCategory *item=[results objectAtIndex:0];
        return item;
    }
    return nil;
}
-(NSString*)getParentCategoryName:(NSString*)guid{
    NSString *match=[NSString stringWithFormat:@"SELF.GUID =='%@'",guid];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
    NSArray *results = [self.categorys filteredArrayUsingPredicate:predicate];
    if (results&&[results count]>0) {
        CaseCategory *item=[results objectAtIndex:0];
        if ([item.Parent length]==0) {
            return item.Name;
        }
        return [self getParentCategoryName:item.Parent];
    }
    return @"";
}
+(NSString*)getParentCategoryName:(NSString*)guid withArray:(NSArray*)arr{
    if (arr==nil||[arr count]==0) {
        return @"";
    }
    NSString *match=[NSString stringWithFormat:@"SELF.GUID =='%@'",guid];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
    NSArray *results = [arr filteredArrayUsingPredicate:predicate];
    if (results&&[results count]>0) {
        CaseCategory *item=[results objectAtIndex:0];
        if ([item.Parent length]==0) {
            return item.Name;
        }
        return [self getParentCategoryName:item.Parent withArray:arr];
    }
    return @"";
}
-(CaseCategory*)getCaseCategoryWithGuid:(NSString*)guid{
    NSString *match=[NSString stringWithFormat:@"SELF.GUID =='%@'",guid];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
    NSArray *results = [self.categorys filteredArrayUsingPredicate:predicate];
    if (results&&[results count]>0) {
        CaseCategory *item=[results objectAtIndex:0];
        return item;
    }
    return nil;
}
-(NSMutableArray*)fillCategoryTreeNodes:(NSString*)parent{
    if (self.categorys==nil||[self.categorys count]==0) {
        return nil;
    }
    CaseCategory *entity=[self getCaseCategoryWithGuid:parent];
    if (entity!=nil) {
        NSMutableArray *source=[self childsTreeNodes:parent];
        NSMutableArray *childs=[self childsObjectTreeNodes:source Level:0];
        return childs;
    }
    return nil;
}
+(CaseCategory*)getHRFirstChildWithGuid:(NSString*)guid{
    CaseCategory *entity=[self getCaseCategoryEntity:guid];
    if(entity!=nil)
    {
        NSArray *arr=[CacheHelper readCacheCaseCategorys];
        if (arr==nil||[arr count]==0) {
            return nil;
        }
        NSString *match=[NSString stringWithFormat:@"SELF.Parent =='%@'",entity.GUID];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:match];
        NSArray *results = [arr filteredArrayUsingPredicate:predicate];
        if (results&&[results count]>0) {
            return [results objectAtIndex:0];
        }
        
    }
    return nil;
}
@end
