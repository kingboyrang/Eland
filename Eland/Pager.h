//
//  Pager.h
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pager : NSObject
@property(nonatomic,assign)  int PageNumber;
@property(nonatomic,assign)  int PageSize;
@property(nonatomic,assign)  int TotalItemsCount;
@property(nonatomic,assign)  int TotalPageCount;
-(NSString*)toXmlString;
@end
