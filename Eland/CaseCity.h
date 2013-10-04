//
//  CaseCity.h
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseCity : NSObject<NSCoding>
@property(nonatomic,copy) NSString *GUID;
@property(nonatomic,copy) NSString *Name;
@property(nonatomic,copy) NSString *ParentGuid;
@end
