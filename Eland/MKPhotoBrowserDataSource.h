//
//  MKPhotoDataSource.h
//  ScrollImageDemo
//
//  Created by rang on 13-8-25.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MKPhotoBrowserDataSource <NSObject>
@required
- (NSInteger)numberOfPhotos;
@optional
- (UIImage *)imageAtIndex:(NSInteger)index;
- (void)deleteImageAtIndex:(NSInteger)index;
@end
