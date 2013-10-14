//
//  CaseImage.h
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModle.h"
@interface CaseImage : BasicModle
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *GUID;
@property(nonatomic,copy) NSString *CaseGuid;
@property(nonatomic,copy) NSString *Content;
@property(nonatomic,copy) NSString *Path;
@property(nonatomic,copy) NSString *Name;//图片文件名
@property(nonatomic,copy) NSString *URL;//图片url地址
-(NSString*)XmlSerialize;
@end
