//
//  TKCaseLabelTextFieldCell.h
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseLabelCell.h"
#import "CaseCameraImage.h"
#import "QBImagePickerController.h"

@protocol CaseImageSelectDelegate <NSObject>
@optional
-(void)finishPhotos:(NSArray*)photos;
-(void)finishCameraPhoto:(UIImage*)image;
-(int)getMaxImageCount;
@end

@interface TKCaseLabelTextFieldCell : TKCaseLabelCell<QBImagePickerControllerDelegate>{
    CaseCameraImage *_cameraImage;
}
@property(nonatomic,strong) UIButton *buttonPhoto;
@property(nonatomic,strong) UIButton *buttonCamera;
@property(nonatomic,assign) int maxImageCount;
@property(nonatomic,assign) UIViewController *showInController;
@property(nonatomic,assign) id<CaseImageSelectDelegate> delegate;
-(void)cameraPhoto:(UIImage*)image;
@end
