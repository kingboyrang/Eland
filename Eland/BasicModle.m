//
//  BasicModle.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "BasicModle.h"

@implementation BasicModle
-(NSString*)getPropertyValue:(NSString*)field{
    if (field==nil||[field length]==0) {
        return @"";
    }
    return field;
}
@end
