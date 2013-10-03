//
//  SearchArgs.h
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pager.h"
#import "BasicModle.h"
@interface SearchArgs : BasicModle
@property(nonatomic,retain) NSMutableArray *Sort;
@property(nonatomic,retain) Pager *Pager;
-(NSString*)toXmlString;
@end
