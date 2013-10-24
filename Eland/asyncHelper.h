//
//  asyncHelper.h
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface asyncHelper : NSObject
+(void)asyncLoadCity:(void (^)(NSArray *result))completed;
+(void)asyncLoadCaseCategory:(void (^)(NSArray *result))completed;
+(void)asyncLoadCaseSettings:(void (^)(NSArray *result))completed;
+(void)backgroundQueueLoad;
+(void)backgroundQueueLoad:(void(^)())completed;
@end
