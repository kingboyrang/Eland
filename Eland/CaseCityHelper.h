//
//  CaseCityHelper.h
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseCityHelper : NSObject
+(NSMutableArray*)sourceFromArray:(NSArray*)arr;
+(NSString*)getCityName:(NSString*)guid;
@end
