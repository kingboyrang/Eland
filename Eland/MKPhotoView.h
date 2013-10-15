//
//  MKPhotoView.h
//  ScrollImageDemo
//
//  Created by rang on 13-8-21.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZGenieView.h"



@interface MKPhotoView : UIScrollView<UIScrollViewDelegate,AZGenieAnimationDelegate>{
@private
    UIImageView *_imageView;
    BOOL _isShow;
    AZGenieView *_genieView;
   
}
@property (nonatomic, assign) NSInteger index;
@property(nonatomic,assign) id scroller;
@property(nonatomic,readonly) UIImage *orginImage;
- (void)setImage:(UIImage *)newImage;
- (void)turnOffZoom;

- (CGPoint)pointToCenterAfterRotation;
- (CGFloat)scaleToRestoreAfterRotation;
- (void)setMaxMinZoomScalesForCurrentBounds;
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale;

-(void)trashPhotoTargetFrame:(CGRect)frame;
@end
