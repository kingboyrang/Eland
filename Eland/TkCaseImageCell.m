//
//  TkCaseImageCell.m
//  Eland
//
//  Created by aJia on 13/10/18.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TkCaseImageCell.h"
#import "Photos.h"
#import "MKPhotoBrowser.h"
@implementation TkCaseImageCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _emptyView= [[TKEmptyView alloc] initWithFrame:CGRectMake((self.bounds.size.width-296)/2.0, 2, 296, 296)
                                                 emptyViewImage:TKEmptyViewImagePhotos
                                                          title:@"案件圖片"
                                                       subtitle:[NSString stringWithFormat:@"最多上傳%@張圖片",self.UpImgNum]];
    [self.contentView addSubview:_emptyView];
   
    
    _PhotoScroll=[[MKPhotoScroll alloc] initWithFrame:_emptyView.frame];
    _PhotoScroll.backgroundColor=[UIColor clearColor];
    _PhotoScroll.delegate=self;
    [self.contentView addSubview:_PhotoScroll];
   
    return self;
}

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
-(void)setUpImgNum:(NSString *)ImgNum{
    if (_UpImgNum!=ImgNum) {
        [_UpImgNum release];
        _UpImgNum=[ImgNum copy];
    }
    _emptyView.subtitleLabel.text=[NSString stringWithFormat:@"最多上傳%@張圖片",_UpImgNum];
}
- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect r=_emptyView.frame;
    r.origin.x=(self.bounds.size.width-r.size.width)/2.0;
    _emptyView.frame=r;
    _PhotoScroll.frame=r;
}
#pragma mark MKPhotoScrollDelegate
-(void)imageViewClick:(UIImageView*)imageView imageIndex:(int)index{
    if (_PhotoScroll) {
        NSArray *source=[_PhotoScroll sourceImages];
        if (source&&[source count]>0) {
            Photos *photo=[[[Photos alloc] init] autorelease];
            [photo addImages:source];
            photo.photoScroll=_PhotoScroll;
            photo.control=self;
            MKPhotoBrowser *browser=[[[MKPhotoBrowser alloc] initWithDataSource:photo andStartWithPhotoAtIndex:index] autorelease];
            browser.showShareButton=NO;
            browser.showTrashButton=YES;
            UINavigationController *nav=[[[UINavigationController alloc] initWithRootViewController:browser] autorelease];
            [self.showInController presentViewController:nav animated:YES completion:nil];
            
        }
    }
}
#pragma mark -
#pragma mark CaseImageSelectDelegate Methods
-(void)finishPhotos:(NSArray*)photos{
    [_PhotoScroll addRangeImage:photos];
}
-(void)finishCameraPhoto:(UIImage*)image{
    [_PhotoScroll addImage:image];
}
-(int)getMaxImageCount{
    return [self.UpImgNum intValue]-[_PhotoScroll imageCount];
}
@end
