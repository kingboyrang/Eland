//
//  MKPhotoScroll.h
//  ScrollImageDemo
//
//  Created by rang on 13-8-14.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  MKPhotoScrollDelegate<NSObject>
@optional
-(void)imageViewClick:(UIImageView*)imageView imageIndex:(int)index;
@end


@interface MKPhotoScroll : UIView<UIScrollViewDelegate>{
    int currentCount;
}
@property(nonatomic,assign) id<MKPhotoScrollDelegate> delegate;
@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) UIPageControl *pageControl;
@property(nonatomic,readonly) NSInteger imageCount;
@property(nonatomic,readonly) NSArray *imageCollection;
@property(nonatomic,readonly) NSArray *sourceImages;
-(void)addImage:(UIImage*)image;
-(void)addRangeImage:(NSArray*)images;
-(void)removeImageIndex:(int)index;
-(void)addRangeURLs:(NSArray*)urls;
@end
