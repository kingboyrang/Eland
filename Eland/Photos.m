//
//  Photos.m
//  ElandSearch
//
//  Created by rang on 13-8-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "Photos.h"

@implementation Photos
@synthesize photoScroll;
@synthesize control;
-(id)init{
    if (self=[super init]) {
        _images=[[NSMutableArray alloc] init];
    }
    return self;
}
-(void)addImage:(UIImage*)image{
    [_images addObject:image];
}
-(void)addImages:(NSArray*)images{
    [_images addObjectsFromArray:images];
}
#pragma mark MKPhotoBrowserDataSource
- (NSInteger)numberOfPhotos{
    return [_images count];
}
- (UIImage *)imageAtIndex:(NSInteger)index{
    return [_images objectAtIndex:index];
}
- (void)deleteImageAtIndex:(NSInteger)index{
    if (index>=0&&index<[_images count]) {
        [_images removeObjectAtIndex:index];
        if (self.photoScroll) {
            [self.photoScroll removeImageIndex:index];
        }
        if (self.control&&[self.control respondsToSelector:@selector(scrollImageCount:)]) {
            SEL sel=NSSelectorFromString(@"scrollImageCount:");
            [self.control performSelector:sel withObject:[_images count]];
        }
    }
}
@end
