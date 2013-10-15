//
//  Photos.h
//  ElandSearch
//
//  Created by rang on 13-8-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKPhotoBrowserDataSource.h"
#import "MKPhotoScroll.h"
@interface Photos : NSObject<MKPhotoBrowserDataSource>{
@private NSMutableArray *_images;
}
@property(nonatomic,assign) MKPhotoScroll *photoScroll;
@property(nonatomic,assign) id control;
-(void)addImage:(UIImage*)image;
-(void)addImages:(NSArray*)images;
@end
